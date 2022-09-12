require 'register_sources_psc/bods_mapping/entity_statement'
require 'register_sources_psc/structs/company_record'
require 'register_sources_oc/structs/resolver_response'

RSpec.describe RegisterSourcesPsc::BodsMapping::EntityStatement do
  subject { described_class.new(psc_record, entity_resolver: entity_resolver) }

  let(:entity_resolver) { double 'entity_resolver' }

  context 'when record is corporate_entity' do
    let(:psc_record) do
      data = {
        "etag": "36c99208e0c14294355583c965e4c3f1",
        "kind": "corporate-entity-person-with-significant-control",
        name: "Foo Bar Limited",
        "address": {
          "premises": "123 Main Street",
          "locality": "Example Town",
          "region": "Exampleshire",
          "postal_code": "EX4 2MP"
        },
        "identification": {
          "country_registered": "United Kingdom",
          "registration_number": "89101112"
        },
        "links": {
          "self": "/company/01234567/persons-with-significant-control/corporate-entity/abcdef123456789"
        }
      }
      RegisterSourcesPsc::CompanyRecord[{ company_number: "123456", data: data }]
    end

    it 'maps successfully' do
      expect(entity_resolver).to receive(:resolve).with(
        RegisterSourcesOc::ResolverRequest[{
          company_number: "89101112",
          name: "Foo Bar Limited",
          country: "United Kingdom",
        }.compact]
      ).and_return RegisterSourcesOc::ResolverResponse[{
        resolved: true,
        reconciliation_response: nil,
        company: {
          company_number: '89101112',
          jurisdiction_code: 'gb',
          name: "Foo Bar Limited",
          company_type: 'company_type',
          incorporation_date: '2020-01-09',
          dissolution_date: '2021-09-07',
          restricted_for_marketing: nil,
          registered_address_in_full: 'registered address',
          registered_address_country: "United Kingdom",
        }
      }]

      result = subject.call
  
      expect(result).to be_a RegisterBodsV2::EntityStatement
    end
  end
end