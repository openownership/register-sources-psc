require 'register_sources_psc/enums/statement_descriptions'

RSpec.describe RegisterSourcesPsc::StatementDescriptions do
  context "when kind is 'psc-exists-but-not-identified'" do
    let(:kind) { 'psc-exists-but-not-identified' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
