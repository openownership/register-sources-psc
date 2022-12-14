require 'register_sources_psc/config/elasticsearch'

require 'register_sources_psc/structs/company_record'

module RegisterSourcesPsc
  module Repositories
    class CompanyRecordRepository      
      UnknownRecordKindError = Class.new(StandardError)
      ElasticsearchError = Class.new(StandardError)

      SearchResult = Struct.new(:record, :score)

      def initialize(client: Config::ELASTICSEARCH_CLIENT, index: Config::ES_COMPANY_RECORD_INDEX)
        @client = client
        @index = index
      end

      def get(etag)
        process_results(
          client.search(
            index: index,
            body: {
              query: {
                nested: {
                  path: "data",
                  query: {
                    bool: {
                      must: [
                        {
                          match: {
                            "data.etag": {
                              query: etag
                            }
                          }
                        }
                      ]
                    }
                  }
                }
              }
            }
          )
        ).first&.record
      end

      def list_by_company_number(company_number)
        process_results(
          client.search(
            index: index,
            body: {
              query: {
                bool: {
                  must: [
                    {
                      match: {
                        company_number: {
                          query: company_number
                        }
                      }
                    }
                  ]
                }
              }
            }
          )
        )
      end

      def store(records)
        return true if records.empty?

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
          raise ElasticsearchError, errors: result['errors']
        end

        true
      end

      private

      attr_reader :client, :index

      def calculate_id(record)
        "#{record.company_number}:#{record.data.etag}"
      end

      def process_results(results)
        hits = results.dig('hits', 'hits') || []
        hits = hits.sort { |hit| hit['_score'] }.reverse

        mapped = hits.map do |hit|
          SearchResult.new(map_es_record(hit['_source']), hit['_score'])
        end

        mapped.sort_by(&:score).reverse
      end

      def map_es_record(record)
        CompanyRecord.new(record)
      end
    end
  end
end
