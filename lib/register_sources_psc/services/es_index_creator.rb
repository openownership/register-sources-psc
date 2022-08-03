require 'register_sources_psc/config/elasticsearch'

module RegisterSourcesPsc
  module Services
    class EsIndexCreator
      def initialize(
        client: Config::ELASTICSEARCH_CLIENT,
        corporate_entity_index: Config::ES_CORPORATE_ENTITY_INDEX,
        individual_person_index: Config::ES_INDIVIDUAL_PERSON_INDEX,
        legal_person_index: Config::ES_LEGAL_PERSON_INDEX,
        psc_statement_index: Config::ES_PSC_STATEMENT_INDEX
      )
        @client = client
        @corporate_entity_index = corporate_entity_index
        @individual_person_index = individual_person_index
        @legal_person_index = legal_person_index
        @psc_statement_index = psc_statement_index
      end

      def create_corporate_entity_index
        client.indices.create index: corporate_entity_index, body: {
          mappings: {
            properties: {
              "address": {
                "type": "nested",
                "properties": {
                  "address_line_1": {
                    "type": "keyword"
                  },
                  "address_line_2": {
                    "type": "keyword"
                  },
                  "care_of": {
                    "type": "keyword"
                  },
                  "country": {
                    "type": "keyword"
                  },
                  "locality": {
                    "type": "keyword"
                  },
                  "postal_code": {
                    "type": "keyword"
                  },
                  "premises": {
                    "type": "keyword"
                  },
                  "region": {
                    "type": "keyword"
                  }
                }
              },
              "ceased_on": {
                "type": "date"
              },
              "etag": {
                "type": "text",
                "fields": {
                  "raw": { 
                    "type":  "keyword"
                  }
                }
              },
              "identification": {
                "type": "nested",
                "properties": {
                  "country_registered": {
                    "type": "keyword"
                  },
                  "legal_authority": {
                    "type": "keyword"
                  },
                  "legal_form": {
                    "type": "keyword"
                  },
                  "place_registered": {
                    "type": "keyword"
                  },
                  "registration_number": {
                    "type": "keyword"
                  },
                }
              },
              "kind": {
                "type": "keyword"
              },
              "links": {
                "type": "nested",
                "properties": {
                  "self": {
                    "type": "keyword"
                  },
                  "statement": {
                    "type": "keyword"
                  }
                }
              },
              "name": {
                "type": "text",
                "fields": {
                  "raw": { 
                    "type":  "keyword"
                  }
                }
              },
              "natures_of_control": {
                "type": "keyword", # array
              },
              "notified_on": {
                "type": "date"
              },
            }
          }
        }
      end

      def create_individual_person_index
        client.indices.create index: individual_person_index, body: {
          mappings: {
            properties: {
              "address": {
                "type": "nested",
                "properties": {
                  "address_line_1": {
                    "type": "keyword"
                  },
                  "address_line_2": {
                    "type": "keyword"
                  },
                  "care_of": {
                    "type": "keyword"
                  },
                  "country": {
                    "type": "keyword"
                  },
                  "locality": {
                    "type": "keyword"
                  },
                  "postal_code": {
                    "type": "keyword"
                  },
                  "premises": {
                    "type": "keyword"
                  },
                  "region": {
                    "type": "keyword"
                  }
                }
              },
              "ceased_on": {
                "type": "date"
              },
              "country_of_residence": {
                "type": "keyword"
              },
              "date_of_birth": {
                "type": "nested",
                "properties": {
                  "day": {
                    "type": "integer"
                  },
                  "month": {
                    "type": "integer"
                  },
                  "year": {
                    "type": "integer"
                  }
                }
              },
              "etag": {
                "type": "text",
                "fields": {
                  "raw": { 
                    "type":  "keyword"
                  }
                }
              },
              "kind": {
                "type": "keyword"
              },
              "links": {
                "type": "nested",
                "properties": {
                  "self": {
                    "type": "keyword"
                  },
                  "statement": {
                    "type": "keyword"
                  }
                }
              },
              "name": {
                "type": "text",
                "fields": {
                  "raw": { 
                    "type":  "keyword"
                  }
                }
              },
              "name_elements": {
                "type": "nested",
                "properties": {
                  "forename": {
                    "type": "text",
                    "fields": {
                      "raw": { 
                        "type":  "keyword"
                      }
                    }
                  },
                  "other_forenames": {
                    "type": "text",
                    "fields": {
                      "raw": { 
                        "type":  "keyword"
                      }
                    }
                  },
                  "surname": {
                    "type": "text",
                    "fields": {
                      "raw": { 
                        "type":  "keyword"
                      }
                    }
                  },
                  "title": {
                    "type": "text",
                    "fields": {
                      "raw": { 
                        "type":  "keyword"
                      }
                    }
                  }
                }
              },
              "nationality": {
                "type": "keyword"
              },
              "natures_of_control": {
                "type": "keyword", # array
              },
              "notified_on": {
                "type": "date"
              },
            }
          }
        }
      end

      def create_legal_person_index
        client.indices.create index: legal_person_index, body: {
          mappings: {
            properties: {}
          }
        }
      end

      def create_psc_statement_index
        client.indices.create index: psc_statement_index, body: {
          mappings: {
            properties: {}
          }
        }
      end

      private

      attr_reader :client, :psc_statement_index, :corporate_entity_index, :individual_person_index, :legal_person_index
    end
  end
end
