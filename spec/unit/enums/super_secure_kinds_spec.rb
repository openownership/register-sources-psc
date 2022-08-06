require 'register_sources_psc/enums/super_secure_kinds'

RSpec.describe RegisterSourcesPsc::SuperSecureKinds do
  context "when kind is 'super-secure-person-with-significant-control'" do
    let(:kind) { 'super-secure-person-with-significant-control' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
