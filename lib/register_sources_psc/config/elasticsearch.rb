require 'elasticsearch'

module RegisterSourcesPsc
  module Config
    MissingEsCredsError = Class.new(StandardError)

    raise MissingEsCredsError unless ENV['ELASTICSEARCH_HOST']

    ELASTICSEARCH_CLIENT = Elasticsearch::Client.new(
      host: "#{ENV.fetch('ELASTICSEARCH_PROTOCOL', 'http')}://elastic:#{ENV.fetch('ELASTICSEARCH_PASSWORD', nil)}@#{ENV.fetch('ELASTICSEARCH_HOST', nil)}:#{ENV.fetch('ELASTICSEARCH_PORT', nil)}",
      transport_options: { ssl: { verify: (ENV.fetch('ELASTICSEARCH_SSL_VERIFY', false) == 'true') } },
      log: false,
    )

    ES_COMPANY_RECORD_INDEX = 'ukpsc_company_records'.freeze
    ES_OVERSEAS_RECORD_INDEX = 'ukpsc_roe_company_records2'.freeze
  end
end
