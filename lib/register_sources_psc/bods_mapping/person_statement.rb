require 'register_bods_v2/structs/person_statement'
require 'register_bods_v2/constants/publisher'
require_relative 'base_statement'

module RegisterSourcesPsc
  module BodsMapping
    class PersonStatement < BaseStatement
      def call
        RegisterBodsV2::PersonStatement.new(
          statementID: statementID,
          statementType: statementType,
          statementDate: statementDate,
          isComponent: isComponent,
          personType: personType,
          unspecifiedPersonDetails: unspecifiedPersonDetails,
          names: names,
          identifiers: identifiers,
          nationalities: nationalities,
          placeOfBirth: placeOfBirth,
          birthDate: birthDate,
          deathDate: deathDate,
          placeOfResidence: placeOfResidence,
          taxResidencies: taxResidencies,
          addresses: addresses,
          hasPepStatus: hasPepStatus,
          pepStatusDetails: pepStatusDetails,
          publicationDetails: publicationDetails,
          source: source,
          annotations: annotations,
          replacesStatements: replacesStatements
        )
      end

      private

      def statementID
        #  statement_id_calculator.statement_id obj
      end
      #def statement_id(obj)
      #  case obj
      #  when Structs::Entity
      #    return nil unless generates_statement?(obj)#
      #    ID_PREFIX + hasher("openownership-register/entity/#{obj.id}/#{obj.self_updated_at}")
      #  when Structs::Relationship
      #    things_that_make_relationship_statements_unique = {
      #      id: obj.id,
      #      updated_at: obj.updated_at,
      #      source_id: statement_id(obj.source),
      #      target_id: statement_id(obj.target),
      #    }
      #    ID_PREFIX + hasher(things_that_make_relationship_statements_unique.to_json)
      #  when Structs::Statement
      #    things_that_make_psc_statement_statements_unique = {
      #      id: obj.id,
      #      updated_at: obj.updated_at,
      #      entity_id: statement_id(obj.entity),
      #    }
      #    ID_PREFIX + hasher(things_that_make_psc_statement_statements_unique.to_json)
      #  else
      #    raise "Unexpected object for statement_id - class: #{obj.class.name}, obj: #{obj.inspect}"
      #  end
      #end

      def statementType
        RegisterBodsV2::StatementTypes['personStatement']
      end

      def statementDate
        # NOT IMPLEMENTED
      end

      def personType
        # KNOWN_PERSON, ANONYMOUS_PERSON, UNKNOWN_PERSON
        RegisterBodsV2::PersonTypes['knownPerson']
      end
      #def unknown_ps_person_type(unknown_person)
      #  case unknown_person.unknown_reason_code
      #  when 'super-secure-person-with-significant-control'
      #    'anonymousPerson'
      #  else
      #    'unknownPerson'
      #  end
      #end

      def identifiers
        identifier_builder.build resolved_record
      end

      def unspecifiedPersonDetails
        #{
        #  reason,
        #  description
        #}
      end

      def names
        # TODO: use resolved data?
        full_name = (data['name_elements'].presence && name_string(data['name_elements'])) || data['name']
        [
          RegisterBodsV2::Name.new(
            type: RegisterBodsV2::NameTypes['individual'],
            fullName: full_name,
            familyName: nil,
            givenName: nil,
            patronymicName: nil
          )
        ]
      end
      NAME_KEYS = %w[forename middle_name surname].freeze
      def name_string(name_elements)
        name_elements.values_at(*NAME_KEYS).map(&:presence).compact.join(' ')
      end

      def nationalities
        nationality = country_from_nationality(data['nationality']).try(:alpha2)
        return unless nationality
        country = ISO3166::Country[nationality]
        return nil if country.blank?
        [
          RegisterBodsV2::Country.new(
            name: country.name,
            code: country.alpha2
          )
        ]
      end
      def country_from_nationality(nationality)
        countries = ISO3166::Country.find_all_countries_by_nationality(nationality)
        return if countries.count > 1 # too ambiguous
        countries[0]
      end

      def placeOfBirth
        # NOT IMPLEMENTED IN REGISTER
      end

      def birthDate
        dob_elements = entity_dob(data['date_of_birth'])
        begin
          dob_elements&.to_date&.iso8601 # TODO - log exceptions but process as nil
        rescue Date::Error
          begin
            new_dob = "#{dob_elements}-01" # TODO: properly handle missing day
            new_dob&.to_date&.iso8601
          rescue Date::Error
            LOGGER.warn "Entity #{id} has invalid dob: #{dob_elements} - trying #{new_dob} also failed"
            nil
          end
        end
      end
      def entity_dob(elements)
        return unless elements
        parts = [elements['year']]
        parts << format('%02d', elements['month']) if elements['month']
        parts << format('%02d', elements['day']) if elements['month'] && elements['day']
        ISO8601::Date.new(parts.join('-'))
      end

      def deathDate
        # NOT IMPLEMENTED IN REGISTER
      end

      def placeOfResidence
        # NOT IMPLEMENTED IN REGISTER
      end
      # TODO: SUGGESTION: data['country_of_residence'].presence,

      def taxResidencies
        # NOT IMPLEMENTED IN REGISTER
      end

      ADDRESS_KEYS = %w[premises address_line_1 address_line_2 locality region postal_code].freeze
      def addresses
        return unless data['address'].presence

        address = data['address'].values_at(*ADDRESS_KEYS).map(&:presence).compact.join(', ')

        return [] if address.blank?

        country_of_residence = data['country_of_residence'].presence
        country = try_parse_country_name_to_code(country_of_residence)

        return [] if country.blank? # TODO: check this

        [
          RegisterBodsV2::Address.new(
            type: nil, # TODO: implement
            address: address,
            postCode: nil,
            country: country
          )
        ]
      end
      def try_parse_country_name_to_code(name)
        return nil if name.blank?
        return ISO3166::Country[name].try(:alpha2) if name.length == 2
        country = ISO3166::Country.find_country_by_name(name)  
        return country.alpha2 if country
        country = ISO3166::Country.find_country_by_alpha3(name)
        return country.alpha2 if country
      end

      def hasPepStatus
        # NOT IMPLEMENTED IN REGISTER
      end

      def pepStatusDetails
        # NOT IMPLEMENTED IN REGISTER
      end
    end
  end
end    
