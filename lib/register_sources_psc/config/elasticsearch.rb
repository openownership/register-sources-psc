# frozen_string_literal: true

require 'elasticsearch'

module RegisterSourcesPsc
  module Config
    ELASTICSEARCH_CLIENT         = Elasticsearch::Client.new
    ELASTICSEARCH_INDEX_COMPANY  = 'ukpsc_company_records'
    ELASTICSEARCH_INDEX_OVERSEAS = 'ukpsc_roe_company_records2'
  end
end
