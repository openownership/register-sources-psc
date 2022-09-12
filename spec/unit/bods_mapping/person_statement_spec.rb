require 'register_sources_psc/bods_mapping/person_statement'
require 'register_sources_psc/structs/company_record'

RSpec.describe RegisterSourcesPsc::BodsMapping::PersonStatement do
  subject { described_class.new(psc_record) }

  let(:psc_record) do
    data = {
      etag: "36c99208e0c14294355583c965e4c3f3",
      "kind": "individual-person-with-significant-control",
      "name_elements": {
        "forename": "Joe",
        "surname": "Bloggs"
      },
      "nationality": "British",
      "country_of_residence": "United Kingdom",
      "notified_on": "2016-04-06",
      "address": {
        "premises": "123 Main Street",
        "locality": "Example Town",
        "region": "Exampleshire",
        "postal_code": "EX4 2MP"
      },
      "date_of_birth": {
        "month": 10,
        "year": 1955
      },
      "natures_of_control": [
        "ownership-of-shares-25-to-50-percent",
        "voting-rights-25-to-50-percent"
      ],
      "links": {
        "self": "/company/01234567/persons-with-significant-control/individual/abcdef123456789"
      }
    }
    RegisterSourcesPsc::CompanyRecord[{ company_number: "123456", data: data }]
  end

  it 'maps successfully' do
    result = subject.call

    expect(result).to be_a RegisterBodsV2::PersonStatement
  end
end
