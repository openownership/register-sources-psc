require 'register_sources_psc/config/elasticsearch'

module RegisterSourcesPsc
  module Services
    class EsIndexCreator
      def initialize(client: Config::ELASTICSEARCH_CLIENT)
        @client = client
      end

      def create_es_index(es_index)
        client.indices.create index: es_index, body: {
          mappings: {
            properties: {
              company_number: {
                type: "keyword",
              },
              data: {
                type: "nested",
                properties: {
                  address: {
                    type: "nested",
                    properties: {
                      address_line_1: {
                        type: "keyword",
                      },
                      address_line_2: {
                        type: "keyword",
                      },
                      care_of: {
                        type: "keyword",
                      },
                      country: {
                        type: "keyword",
                      },
                      locality: {
                        type: "keyword",
                      },
                      postal_code: {
                        type: "keyword",
                      },
                      premises: {
                        type: "keyword",
                      },
                      region: {
                        type: "keyword",
                      },
                    },
                  },
                  ceased: {
                    type: "boolean",
                  },
                  ceased_on: {
                    type: "date",
                  },
                  country_of_residence: {
                    type: "keyword",
                  },
                  date_of_birth: {
                    type: "nested",
                    properties: {
                      day: {
                        type: "integer",
                      },
                      month: {
                        type: "integer",
                      },
                      year: {
                        type: "integer",
                      },
                    },
                  },
                  description: {
                    type: "keyword",
                  },
                  etag: {
                    type: "keyword",
                  },
                  identification: {
                    type: "nested",
                    properties: {
                      country_registered: {
                        type: "keyword",
                      },
                      legal_authority: {
                        type: "keyword",
                      },
                      legal_form: {
                        type: "keyword",
                      },
                      place_registered: {
                        type: "keyword",
                      },
                      registration_number: {
                        type: "keyword",
                      },
                    },
                  },
                  is_sanctioned: {
                    type: "boolean",
                  },
                  kind: {
                    type: "keyword",
                  },
                  linked_psc_name: {
                    type: "text",
                    fields: {
                      raw: {
                        type: "keyword",
                      },
                    },
                  },
                  links: {
                    type: "nested",
                    properties: {
                      self: {
                        type: "keyword",
                      },
                      statement: {
                        type: "keyword",
                      },
                    },
                  },
                  name: {
                    type: "text",
                    fields: {
                      raw: {
                        type: "keyword",
                      },
                    },
                  },
                  name_elements: {
                    type: "nested",
                    properties: {
                      forename: {
                        type: "text",
                        fields: {
                          raw: {
                            type: "keyword",
                          },
                        },
                      },
                      other_forenames: {
                        type: "text",
                        fields: {
                          raw: {
                            type: "keyword",
                          },
                        },
                      },
                      surname: {
                        type: "text",
                        fields: {
                          raw: {
                            type: "keyword",
                          },
                        },
                      },
                      title: {
                        type: "text",
                        fields: {
                          raw: {
                            type: "keyword",
                          },
                        },
                      },
                    },
                  },
                  nationality: {
                    type: "keyword",
                  },
                  natures_of_control: {
                    type: "keyword", # array
                  },
                  notified_on: {
                    type: "date",
                  },
                  principal_office_address: {
                    type: "nested",
                    properties: {
                      address_line_1: {
                        type: "keyword",
                      },
                      address_line_2: {
                        type: "keyword",
                      },
                      care_of: {
                        type: "keyword",
                      },
                      country: {
                        type: "keyword",
                      },
                      locality: {
                        type: "keyword",
                      },
                      postal_code: {
                        type: "keyword",
                      },
                      premises: {
                        type: "keyword",
                      },
                      region: {
                        type: "keyword",
                      },
                    },
                  },
                  restrictions_notice_withdrawal_reason: {
                    type: "keyword",
                  },
                  statement: {
                    type: "keyword",
                  },
                },
              },
            },
          },
        }
      end

      private

      attr_reader :client
    end
  end
end
