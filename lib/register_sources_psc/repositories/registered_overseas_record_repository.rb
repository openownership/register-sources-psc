require 'register_sources_psc/config/elasticsearch'

require 'register_sources_psc/structs/company_record'
require 'register_sources_psc/repositories/company_record_repository'

module RegisterSourcesPsc
  module Repositories
    class RegisteredOverseasRecordRepository < CompanyRecordRepository
      def initialize(client: Config::ELASTICSEARCH_CLIENT, index: Config::ES_OVERSEAS_RECORD_INDEX)
        @client = client
        @index = index
      end
    end
  end
end
