# frozen_string_literal: true

require 'register_sources_psc/enums/statement_kinds'

RSpec.describe RegisterSourcesPsc::StatementKinds do
  context "when kind is 'persons-with-significant-control-statement'" do
    let(:kind) { 'persons-with-significant-control-statement' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
