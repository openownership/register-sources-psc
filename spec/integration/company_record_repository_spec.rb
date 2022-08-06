require 'elasticsearch'
require 'register_sources_psc/repositories/company_record_repository'
require 'register_sources_psc/services/es_index_creator'
require 'register_sources_psc/structs/company_record'

RSpec.describe RegisterSourcesPsc::Repositories::CompanyRecordRepository do
  subject { described_class.new(client: es_client, index: index) }

  let(:index) { SecureRandom.uuid }
  let(:es_client) do
    Elasticsearch::Client.new(
      host: "http://elastic:#{ENV['ELASTICSEARCH_PASSWORD']}@#{ENV['ELASTICSEARCH_HOST']}:#{ENV['ELASTICSEARCH_PORT']}",
      transport_options: { ssl: { verify: false } },
      log: false
    )
  end

  let(:corporate_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_corporate.json'),
        symbolize_names: true
      )
    )
  end

  let(:individual_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_individual.json'),
        symbolize_names: true
      )
    )
  end

  let(:legal_person_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_legal.json'),
        symbolize_names: true
      )
    )
  end

  let(:statement_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_statement.json'),
        symbolize_names: true
      )
    )
  end

  let(:super_secure_record) do
    RegisterSourcesPsc::CompanyRecord.new(
      **JSON.parse(
        File.read('spec/fixtures/psc_super_secure.json'),
        symbolize_names: true
      )
    )
  end

  before do
    index_creator = RegisterSourcesPsc::Services::EsIndexCreator.new(
      company_record_index: index,
      client: es_client
    )
    index_creator.create_company_record_index
  end

  describe '#store' do
    it 'stores' do
      records = [
        corporate_record,
        individual_record,
        legal_person_record,
        statement_record,
        super_secure_record,
      ]

      subject.store(records)

      sleep 1 # eventually consistent, give time

      results = subject.get()

      expect(results).not_to be_empty
      result_records = results.map(&:record).sort_by { |record| record.data.etag }
      expect(result_records).to eq records.sort_by { |record| record.data.etag }
    end
  end
end
