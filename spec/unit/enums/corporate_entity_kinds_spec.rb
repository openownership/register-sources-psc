# frozen_string_literal: true

require 'register_sources_psc/enums/corporate_entity_kinds'

RSpec.describe RegisterSourcesPsc::CorporateEntityKinds do
  context "when kind is 'corporate-entity-person-with-significant-control'" do
    let(:kind) { 'corporate-entity-person-with-significant-control' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
