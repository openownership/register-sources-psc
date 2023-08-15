require 'register_sources_psc/enums/psc_stream_event_kinds'

RSpec.describe RegisterSourcesPsc::PscStreamEventKinds do
  context "when value is 'changed'" do
    let(:value) { 'changed' }

    it 'maps value' do
      expect(described_class[value]).to eq value
    end
  end
end
