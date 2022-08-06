require 'register_sources_psc/enums/individual_kinds'

RSpec.describe RegisterSourcesPsc::IndividualKinds do
  context "when kind is 'individual-person-with-significant-control'" do
    let(:kind) { 'individual-person-with-significant-control' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
