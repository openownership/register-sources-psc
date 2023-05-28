require 'register_sources_psc/structs/company_record'

RSpec.describe RegisterSourcesPsc::CompanyRecord do
  let(:kind) { 'individual-person-with-significant-control' }
  let(:valid_company_record) do
    {
      company_number: "01234567",
      data: {
        etag: "36c99208e0c14294355583c965e4c3f3",
        kind:,
        name_elements: {
          forename: "Joe",
          surname: "Bloggs",
        },
        nationality: "British",
        country_of_residence: "United Kingdom",
        notified_on: "2016-04-06",
        address: {
          premises: "123 Main Street",
          locality: "Example Town",
          region: "Exampleshire",
          postal_code: "EX4 2MP",
        },
        date_of_birth: {
          month: 10,
          year: 1955,
        },
        natures_of_control: %w[
          ownership-of-shares-25-to-50-percent
          voting-rights-25-to-50-percent
        ],
        links: {
          self: "/company/01234567/persons-with-significant-control/individual/abcdef123456789",
        },
      },
    }
  end

  it 'allows company record' do
    company_record = described_class[valid_company_record]

    expect(company_record.company_number).to eq "01234567"
    expect(company_record.data).to be_a RegisterSourcesPsc::Individual
    expect(company_record.data.etag).to eq "36c99208e0c14294355583c965e4c3f3"
    expect(company_record.data.notified_on).to eq "2016-04-06"
  end

  describe '#roe?' do
    context 'when kind is not beneficial owner' do
      it 'returns false' do
        company_record = described_class[valid_company_record]
        expect(company_record.roe?).to be false
      end
    end

    context 'when kind is beneficial owner' do
      let(:kind) { 'individual-beneficial-owner' }

      it 'returns true' do
        company_record = described_class[valid_company_record]
        expect(company_record.roe?).to be true
      end
    end
  end
end
