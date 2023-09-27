# frozen_string_literal: true

require 'register_sources_psc/enums/psc_stream_resource_kinds'

RSpec.describe RegisterSourcesPsc::PscStreamResourceKinds do
  context "when value is 'company-profile#company-profile'" do
    let(:value) { 'company-profile#company-profile' }

    it 'maps value' do
      expect(described_class[value]).to eq value
    end
  end
end
