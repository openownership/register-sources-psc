require 'elasticsearch'
require 'register_sources_psc/repositories/psc_statement_repository'
require 'register_sources_psc/services/es_index_creator'
require 'register_sources_psc/structs/statement'

RSpec.describe RegisterSourcesPsc::Repositories::PscStatementRepository do
  subject { described_class.new(client: es_client, index: index) }

  let(:index) { SecureRandom.uuid }
  let(:es_client) do
    Elasticsearch::Client.new(
      host: "http://elastic:#{ENV['ELASTICSEARCH_PASSWORD']}@#{ENV['ELASTICSEARCH_HOST']}:#{ENV['ELASTICSEARCH_PORT']}",
      transport_options: { ssl: { verify: false } },
      log: false
    )
  end

  let(:psc_statement) do
    content = File.read('spec/fixtures/psc_statement.json')
    RegisterSourcesPsc::Statement.new(
      JSON.parse(content, symbolize_names: true)[:data]
    )
  end

  before do
    index_creator = RegisterSourcesPsc::Services::EsIndexCreator.new(
      psc_statement_index: index,
      client: es_client
    )
    index_creator.create_psc_statement_index
  end

  describe '#store' do
    it 'stores' do
      records = [
        psc_statement
      ]

      subject.store(records)

      sleep 1 # eventually consistent, give time

      results = subject.get()

      expect(results).not_to be_empty
      expect(results[0].record).to eq records[0]
    end
  end
end
