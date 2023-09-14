# frozen_string_literal: true

require_relative '../config/elasticsearch'
require_relative '../structs/company_record'

BodsIdentifier = Struct.new(:id, :schemeName)

module RegisterSourcesPsc
  module Repositories
    class CompanyRecordRepository
      ElasticsearchError = Class.new(StandardError)

      SearchResult = Struct.new(:record, :score)

      class SearchResults < Array
        def initialize(arr, total_count: nil, aggs: nil)
          @total_count = total_count || arr.to_a.count
          @aggs = aggs

          super(arr)
        end

        attr_reader :total_count, :aggs
      end

      def initialize(client: Config::ELASTICSEARCH_CLIENT, index: Config::ELASTICSEARCH_INDEX_COMPANY)
        @client = client
        @index = index
      end

      attr_reader :client, :index

      def get(etag)
        process_results(
          client.search(
            index:,
            body: {
              query: {
                nested: {
                  path: 'data',
                  query: {
                    bool: {
                      must: [
                        {
                          match: {
                            'data.etag': {
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
        # strip leading zeros
        company_number = company_number[1..] while company_number[0] == '0'

        # make list
        company_numbers = []
        while company_number.length <= 8
          company_numbers << company_number
          company_number = "0#{company_number}"
        end

        process_results(
          client.search(
            index:,
            body: {
              query: {
                bool: {
                  should: company_numbers.map { |company_num|
                    {
                      match: {
                        company_number: {
                          query: company_num
                        }
                      }
                    }
                  } + company_numbers.map do |company_num|
                    {
                      nested: {
                        path: 'data.identification',
                        query: {
                          bool: {
                            must: [
                              {
                                match: {
                                  'data.identification.registration_number': {
                                    query: company_num
                                  }
                                }
                              }
                            ]
                          }
                        }
                      }
                    }
                  end
                }
              },
              size: 10_000
            }
          )
        )
      end

      def store(records)
        return true if records.empty?

        operations = records.map do |record|
          {
            index: {
              _index: index,
              _id: calculate_id(record),
              data: record.to_h
            }
          }
        end

        result = client.bulk(body: operations)

        raise ElasticsearchError, errors: result['errors'] if result['errors']

        true
      end

      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      def build_get_by_bods_identifiers(identifiers)
        company_ids = []
        links = []
        identifiers.each do |identifier|
          if identifier.schemeName == 'GB Persons Of Significant Control Register'
            links << identifier.id
          else
            company_ids << identifier.id
          end
        end

        return if links.empty? && company_ids.empty?

        {
          bool: {
            must: [
              {
                term: {
                  _index: index,
                },
              },
              {
                bool: {
                  should: company_ids.map { |company_id|
                    {
                      bool: {
                        must: [
                          { match: { company_number: { query: company_id } } }
                        ]
                      }
                    }
                  } + company_ids.map { |company_id|
                    {
                      bool: {
                        must: [
                          {
                            nested: {
                              path: 'data.identification',
                              query: {
                                bool: {
                                  must: [
                                    { match: { 'data.identification.registration_number': { query: company_id } } }
                                  ]
                                }
                              }
                            }
                          }
                        ]
                      }
                    }
                  } + links.map do |link|
                    {
                      bool: {
                        must: [
                          {
                            nested: {
                              path: 'data.links',
                              query: {
                                bool: {
                                  must: [
                                    { match: { 'data.links.self': { query: link } } }
                                  ]
                                }
                              }
                            }
                          }
                        ]
                      }
                    }
                  end,
                },
              },
            ],
          },
        }
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

      private

      def calculate_id(record)
        "#{record.company_number}:#{record.data.etag}"
      end

      def process_results(results)
        hits = results.dig('hits', 'hits') || []
        hits = hits.sort { |hit| hit['_score'] }.reverse # rubocop:disable Lint/UnexpectedBlockArity # FIXME
        total_count = results.dig('hits', 'total', 'value') || 0

        mapped = hits.map do |hit|
          SearchResult.new(map_es_record(hit['_source']), hit['_score'])
        end

        SearchResults.new(
          mapped.sort_by(&:score).reverse,
          total_count:,
          aggs: results['aggregations'],
        )
      end

      def map_es_record(record)
        CompanyRecord.new(record)
      end
    end
  end
end
