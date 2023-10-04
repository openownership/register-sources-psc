# frozen_string_literal: true

require_relative '../config/elasticsearch'
require_relative '../structs/company_record'
require_relative 'company_record_repository'

module RegisterSourcesPsc
  module Repositories
    class RegisteredOverseasRecordRepository < CompanyRecordRepository
      def initialize(client: Config::ELASTICSEARCH_CLIENT, index: Config::ELASTICSEARCH_INDEX_OVERSEAS)
        super(client, index)
      end
    end
  end
end
