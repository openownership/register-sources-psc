require 'register_sources_psc/services/es_index_creator'

RSpec.describe RegisterSourcesPsc::Services::EsIndexCreator do
  subject { described_class.new(client: client, company_record_index: index) }

  let(:client) { double 'client', indices: double('indices') }
  let(:index) { double 'index' }

  describe '#create_company_record_index' do
    it 'calls client' do
      expect(client.indices).to receive(:create).with a_hash_including(
        index: index
      )

      subject.create_company_record_index
    end
  end
end
