require 'register_sources_psc/services/es_index_creator'

RSpec.describe RegisterSourcesPsc::Services::EsIndexCreator do
  subject { described_class.new(client: client) }

  let(:client) { double 'client', indices: double('indices') }
  let(:index) { double 'index' }

  describe '#create_es_index' do
    it 'calls client' do
      expect(client.indices).to receive(:create).with a_hash_including(
        index: index
      )

      subject.create_es_index(index)
    end
  end
end
