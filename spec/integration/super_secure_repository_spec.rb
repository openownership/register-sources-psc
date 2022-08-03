require 'elasticsearch'
require 'register_sources_psc/repositories/super_secure_repository'
require 'register_sources_psc/services/es_index_creator'
require 'register_sources_psc/structs/super_secure'

RSpec.describe RegisterSourcesPsc::Repositories::SuperSecureRepository do
  subject { described_class.new(client: es_client, index: index) }

  let(:index) { SecureRandom.uuid }
  let(:es_client) do
    Elasticsearch::Client.new(
      host: "http://elastic:#{ENV['ELASTICSEARCH_PASSWORD']}@#{ENV['ELASTICSEARCH_HOST']}:#{ENV['ELASTICSEARCH_PORT']}",
      transport_options: { ssl: { verify: false } },
      log: false
    )
  end

  let(:super_secure) do
    content = File.read('spec/fixtures/psc_super_secure.json')
    RegisterSourcesPsc::SuperSecure.new(
      JSON.parse(content, symbolize_names: true)[:data]
    )
  end

  before do
    index_creator = RegisterSourcesPsc::Services::EsIndexCreator.new(
      super_secure_index: index,
      client: es_client
    )
    index_creator.create_super_secure_index
  end

  describe '#store' do
    it 'stores' do
      records = [
        super_secure
      ]

      subject.store(records)

      sleep 1 # eventually consistent, give time

      results = subject.get()

      expect(results).not_to be_empty
      expect(results[0].record).to eq records[0]
    end
  end
end
