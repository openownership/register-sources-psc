# frozen_string_literal: true

require 'register_sources_psc/structs/legal_person'

RSpec.describe RegisterSourcesPsc::LegalPerson do
  let(:valid_params) do
    {
      etag: '36c99208e0c14294355583c965e4c3f4',
      kind: 'legal-person-person-with-significant-control',
      name: 'Foo Bar Limited',
      identification: {
        country_registered: 'United Kingdom',
        registration_number: '89101112'
      },
      links: {
        self: '/company/01234567/persons-with-significant-control/legal-person/abcdef123456789'
      }
    }
  end

  it 'allows valid params' do
    legal_person = described_class[valid_params]

    expect(legal_person.etag).to eq '36c99208e0c14294355583c965e4c3f4'
    expect(legal_person.name).to eq 'Foo Bar Limited'
  end
end
