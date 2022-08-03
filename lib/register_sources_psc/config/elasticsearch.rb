require 'elasticsearch'

module RegisterSourcesPsc
  module Config
    MissingEsCredsError = Class.new(StandardError)

    raise MissingEsCredsError unless ENV['ELASTICSEARCH_HOST']

    ELASTICSEARCH_CLIENT = Elasticsearch::Client.new(
      host: "#{ENV.fetch('ELASTICSEARCH_PROTOCOL', 'http')}://elastic:#{ENV['ELASTICSEARCH_PASSWORD']}@#{ENV['ELASTICSEARCH_HOST']}:#{ENV['ELASTICSEARCH_PORT']}",
      transport_options: { ssl: { verify: (ENV.fetch('ELASTICSEARCH_SSL_VERIFY', false) == 'true') } },
      log: false
    )

    ES_CORPORATE_ENTITY_INDEX = 'ukpsc_corporate_entities'
    ES_INDIVIDUAL_PERSON_INDEX = 'ukpsc_individual_persons'
    ES_LEGAL_PERSON_INDEX = 'ukpsc_legal_persons'
    ES_PSC_STATEMENT_INDEX = 'ukpsc_statements'
    ES_SUPER_SECURE_INDEX = 'ukpsc_super_secure'
  end
end
