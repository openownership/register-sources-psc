# frozen_string_literal: true

require 'register_sources_psc/enums/restrictions_notices'

RSpec.describe RegisterSourcesPsc::RestrictionsNotices do
  context "when kind is 'restrictions-notice-withdrawn-by-court-order'" do
    let(:kind) { 'restrictions-notice-withdrawn-by-court-order' }

    it 'maps kind' do
      expect(described_class[kind]).to eq kind
    end
  end
end
