# frozen_string_literal: true

require 'elasticsearch'

module RegisterSourcesPsc
  module Config
    ELASTICSEARCH_CLIENT = Elasticsearch::Client.new

    ES_COMPANY_RECORD_INDEX  = 'ukpsc_company_records'
    ES_OVERSEAS_RECORD_INDEX = 'ukpsc_roe_company_records2'
  end
end
