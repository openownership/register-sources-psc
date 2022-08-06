require 'register_sources_psc/enums/descriptions'

RSpec.describe RegisterSourcesPsc::Descriptions do
  context "when kind is 'ownership-of-shares-25-to-50-percent'" do
    let(:kind) { 'ownership-of-shares-25-to-50-percent' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
