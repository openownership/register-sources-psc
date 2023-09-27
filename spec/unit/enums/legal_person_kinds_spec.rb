# frozen_string_literal: true

require 'register_sources_psc/enums/legal_person_kinds'

RSpec.describe RegisterSourcesPsc::LegalPersonKinds do
  context "when kind is 'legal-person-person-with-significant-control'" do
    let(:kind) { 'legal-person-person-with-significant-control' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
