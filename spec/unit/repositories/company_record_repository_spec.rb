# frozen_string_literal: true

require 'register_sources_psc/repositories/company_record_repository'

RSpec.describe RegisterSourcesPsc::Repositories::CompanyRecordRepository do
  subject { described_class.new(client:, index:) }

  let(:client) { double 'client' }
  let(:index) { double 'index' }

  let(:company_record_h) do
    {
      company_number: '01234567',
      data: {
        etag: '36c99208e0c14294355583c965e4c3f3',
        kind: 'individual-person-with-significant-control',
        name_elements: {
          forename: 'Joe',
          surname: 'Bloggs'
        },
        nationality: 'British',
        country_of_residence: 'United Kingdom',
        notified_on: '2016-04-06',
        address: {
          premises: '123 Main Street',
          locality: 'Example Town',
          region: 'Exampleshire',
          postal_code: 'EX4 2MP'
        },
        date_of_birth: {
          month: 10,
          year: 1955
        },
        natures_of_control: %w[
          ownership-of-shares-25-to-50-percent
          voting-rights-25-to-50-percent
        ],
        links: {
          self: '/company/01234567/persons-with-significant-control/individual/abcdef123456789'
        }
      }
    }
  end
  let(:company_record) { RegisterSourcesPsc::CompanyRecord[company_record_h] }

  describe '#get' do
    let(:expected_get_query) do
      {
        query: {
          nested: {
            path: 'data',
            query: {
              bool: {
                must: [
                  {
                    match: {
                      'data.etag': {
                        query: company_record.data.etag
                      }
                    }
                  }
                ]
              }
            }
          }
        }
      }
    end

    context 'when matching record exists' do
      it 'returns matching record' do
        expect(client).to receive(:search).with(
          index:,
          body: expected_get_query
        ).and_return({
                       'hits' => { 'hits' => [{ '_score' => 0.9, '_source' => company_record_h }] }
                     })

        expect(subject.get(company_record.data.etag)).to eq company_record
      end
    end

    context 'when matching record does not exist' do
      it 'returns nil' do
        expect(client).to receive(:search).with(
          index:,
          body: expected_get_query
        ).and_return({
                       'hits' => { 'hits' => [] }
                     })

        expect(subject.get(company_record.data.etag)).to be_nil
      end
    end
  end

  describe '#list_by_company_number' do
    let(:expected_list_query) do
      {
        query: {
          bool: {
            should: [
              {
                match: {
                  company_number: {
                    query: '1234567'
                  }
                }
              },
              {
                match: {
                  company_number: {
                    query: '01234567'
                  }
                }
              },
              {
                nested: {
                  path: 'data.identification',
                  query: {
                    bool: {
                      must: [
                        {
                          match: {
                            'data.identification.registration_number': {
                              query: '1234567'
                            }
                          }
                        }
                      ]
                    }
                  }
                }
              },
              {
                nested: {
                  path: 'data.identification',
                  query: {
                    bool: {
                      must: [
                        {
                          match: {
                            'data.identification.registration_number': {
                              query: '01234567'
                            }
                          }
                        }
                      ]
                    }
                  }
                }
              }
            ]
          }
        },
        size: 10_000
      }
    end

    context 'when results exist' do
      it 'returns results' do
        expect(client).to receive(:search).with(
          index:,
          body: expected_list_query
        ).and_return({
                       'hits' => { 'hits' => [{ '_score' => 0.9, '_source' => company_record_h }] }
                     })

        expect(subject.list_by_company_number(company_record.company_number)).to eq [
          described_class::SearchResult.new(company_record, 0.9)
        ]
      end
    end

    context 'when results are empty' do
      it 'returns an empty array' do
        expect(client).to receive(:search).with(
          index:,
          body: expected_list_query
        ).and_return({
                       'hits' => { 'hits' => [] }
                     })

        expect(subject.list_by_company_number(company_record.company_number)).to eq []
      end
    end
  end

  describe '#store' do
    context 'when successful' do
      it 'returns true' do
        expect(client).to receive(:bulk).with(
          body: [
            {
              index: {
                _index: index,
                _id: '01234567:36c99208e0c14294355583c965e4c3f3',
                data: company_record_h
              }
            }
          ]
        ).and_return({})

        expect(subject.store([company_record])).to be true
      end
    end

    context 'when items to store are empty' do
      it 'returns true without calling client' do
        expect(client).not_to receive(:bulk)

        expect(subject.store([])).to be true
      end
    end

    context 'when response has errors' do
      it 'raises an ElasticsearchError error' do
        expect(client).to receive(:bulk).and_return('errors' => 'errors')

        expect { subject.store([company_record]) }.to raise_error(described_class::ElasticsearchError)
      end
    end
  end
end
