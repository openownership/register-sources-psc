# frozen_string_literal: true

require 'register_sources_psc/enums/super_secure_descriptions'

RSpec.describe RegisterSourcesPsc::SuperSecureDescriptions do
  context "when kind is 'super-secure-persons-with-significant-control'" do
    let(:kind) { 'super-secure-persons-with-significant-control' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
