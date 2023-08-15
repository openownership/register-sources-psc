require 'register_sources_psc/structs/corporate_entity'

RSpec.describe RegisterSourcesPsc::CorporateEntity do
  let(:valid_corporate_entity) do
    {
      etag: "36c99208e0c14294355583c965e4c3f1",
      kind: "corporate-entity-person-with-significant-control",
      name: "Foo Bar Limited",
      identification: {
        country_registered: "United Kingdom",
        registration_number: "89101112",
      },
      links: {
        self: "/company/01234567/persons-with-significant-control/corporate-entity/abcdef123456789",
      },
    }
  end

  it 'allows corporate_entity' do
    corporate_entity = described_class[valid_corporate_entity]

    expect(corporate_entity.etag).to eq "36c99208e0c14294355583c965e4c3f1"
    expect(corporate_entity.name).to eq "Foo Bar Limited"
  end
end
