# frozen_string_literal: true

require 'elasticsearch'
require 'ostruct'
require 'register_sources_psc/repository'
require 'register_sources_psc/services/es_index_creator'
require 'register_sources_psc/structs/company_record'

RSpec.describe RegisterSourcesPsc::Repository do
  subject { described_class.new(client: es_client, index:) }

  let(:index) { "tmp-#{SecureRandom.uuid}" }
  let(:es_client) { Elasticsearch::Client.new }

  let(:corporate_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_corporate.json'),
        symbolize_names: true
      )
    )
  end

  let(:individual_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_individual.json'),
        symbolize_names: true
      )
    )
  end

  let(:legal_person_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_legal.json'),
        symbolize_names: true
      )
    )
  end

  let(:statement_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_statement.json'),
        symbolize_names: true
      )
    )
  end

  let(:super_secure_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_super_secure.json'),
        symbolize_names: true
      )
    )
  end

  before do
    index_creator = RegisterSourcesPsc::Services::EsIndexCreator.new(client: es_client)
    index_creator.create_index(index)
  end

  describe '#store' do
    it 'stores' do
      records = [
        corporate_record,
        individual_record,
        legal_person_record,
        statement_record,
        super_secure_record
      ]

      subject.store(records)

      sleep 1 # eventually consistent, give time

      results = subject.list_by_company_number('1234567')

      expect(results).not_to be_empty
      result_records = results.map(&:record).sort_by { |record| record.data.etag }
      expect(result_records).to eq(records.sort_by { |record| record.data.etag })

      expect(subject.get(corporate_record.data.etag)).to eq corporate_record

      # When records do not exist
      expect(subject.get('missing')).to be_nil
      expect(subject.list_by_company_number('missing')).to eq []
    end
  end
end
