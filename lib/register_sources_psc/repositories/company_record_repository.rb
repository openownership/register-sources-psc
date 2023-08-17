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
            index:,
            body: {
              query: {
                nested: {
                  path: "data",
                  query: {
                    bool: {
                      must: [
                        {
                          match: {
                            'data.etag': {
                              query: etag,
                            },
                          },
                        },
                      ],
                    },
                  },
                },
              },
            },
          ),
        ).first&.record
      end

      def list_by_company_number(company_number)
        # strip leading zeros
        while company_number[0] == "0"
          company_number = company_number[1..]
        end

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
                          query: company_num,
                        },
                      },
                    }
                  } + company_numbers.map do |company_num|
                    {
                      nested: {
                        path: "data.identification",
                        query: {
                          bool: {
                            must: [
                              {
                                match: {
                                  'data.identification.registration_number': {
                                    query: company_num,
                                  },
                                },
                              },
                            ],
                          },
                        },
                      },
                    }
                  end,
                },
              },
              size: 10_000,
            },
          ),
        )
      end

      def store(records)
        return true if records.empty?

        operations = records.map do |record|
          {
            index: {
              _index: index,
              _id: calculate_id(record),
              data: record.to_h,
            },
          }
        end

        result = client.bulk(body: operations)

        if result['errors']
          raise ElasticsearchError, errors: result['errors']
        end

        true
      end

      def get_by_bods_identifiers(identifiers, per_page: nil)
        company_ids = []
        links = []
        identifiers.each do |identifier|
          if identifier.schemeName == 'GB Persons Of Significant Control Register'
            links << identifier.id
          else
            company_ids << identifier.id
          end
        end

        return [] if links.empty? && company_ids.empty?

        process_results(
          client.search(
            index:,
            body: {
              query: {
                bool: {
                  should: company_ids.map { |company_id|
                    {
                      bool: {
                        must: [
                          { match: { company_number: { query: company_id } } },
                        ],
                      },
                    }
                  } + company_ids.map { |company_id|
                    {
                      bool: {
                        must: [
                          {
                            nested: {
                              path: "data.identification",
                              query: {
                                bool: {
                                  must: [
                                    { match: { 'data.identification.registration_number': { query: company_id } } },
                                  ],
                                },
                              },
                            },
                          },
                        ],
                      },
                    }
                  } + links.map do |link|
                    {
                      bool: {
                        must: [
                          {
                            nested: {
                              path: "data.links",
                              query: {
                                bool: {
                                  must: [
                                    { match: { 'data.links.self': { query: link } } },
                                  ],
                                },
                              },
                            },
                          },
                        ],
                      },
                    }
                  end,
                },
              },
              size: per_page || 10_000,
            },
          ),
        ).map(&:record)
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
