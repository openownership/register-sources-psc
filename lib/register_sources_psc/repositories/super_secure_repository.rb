require 'digest'
require 'json'
require 'register_sources_psc/config/elasticsearch'
require 'register_sources_psc/structs/super_secure'
require 'active_support/core_ext/hash/indifferent_access'

module RegisterSourcesPsc
  module Repositories
    class SuperSecureRepository
      SearchResult = Struct.new(:record, :score)

      def initialize(client: Config::ELASTICSEARCH_CLIENT, index: Config::ES_SUPER_SECURE_INDEX)
        @client = client
        @index = index
      end

      def get()
        process_results(
          client.search(
            index: index,
            body: {
              query: {
                bool: {}
              }
            }
          )
        )
      end

      def store(records)
        operations = records.map do |record|
          {
            index:  {
              _index: index,
              _id: calculate_id(record),
              data: record.to_h
            }
          }
        end

        result = client.bulk(body: operations)

        if result['errors']
          print result, "\n\n"
          raise 'error'
        end

        result
      end

      private

      attr_reader :client, :index

      def calculate_id(record)
        "#{record.kind}" # TODO: use etag
      end

      def process_results(results)
        hits = results.dig('hits', 'hits') || []
        hits = hits.sort { |hit| hit['_score'] }.reverse

        mapped = hits.map do |hit|
          source = JSON.parse(hit['_source'].to_json, symbolize_names: true)

          SearchResult.new(
            SuperSecure.new(**source),
            hit['_score']
          )
        end

        mapped.sort_by(&:score).reverse
      end
    end
  end
end
