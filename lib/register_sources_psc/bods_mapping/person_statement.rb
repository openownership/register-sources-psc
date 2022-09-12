require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'
require 'countries'
require 'iso8601'

require 'register_bods_v2/structs/person_statement'
require 'register_bods_v2/constants/publisher'
require_relative 'base_statement'

module RegisterSourcesPsc
  module BodsMapping
    class PersonStatement < BaseStatement
      def call
        RegisterBodsV2::PersonStatement[{
          statementID: statement_id,
          statementType: statement_type,
          # statementDate: statement_date,
          isComponent: is_component,
          personType: person_type,
          unspecifiedPersonDetails: unspecified_person_details,
          names: names,
          identifiers: identifiers,
          nationalities: nationalities,
          placeOfBirth: place_of_birth,
          birthDate: birth_date,
          deathDate: death_date,
          placeOfResidence: place_of_residence,
          taxResidencies: tax_residencies,
          addresses: addresses,
          hasPepStatus: has_pep_status,
          pepStatusDetails: pep_status_details,
          publicationDetails: publication_details,
          source: source,
          annotations: annotations,
          replacesStatements: replaces_statements
        }.compact]
      end

      private

      def statement_id
        obj_id = "TODO" # TODO: implement object id
        self_updated_at = "something" # TODO: implement self_updated_at
        ID_PREFIX + hasher("openownership-register/entity/#{obj_id}/#{self_updated_at}")
      end

      def statement_type
        RegisterBodsV2::StatementTypes['personStatement']
      end

      def statement_date
        # NOT IMPLEMENTED
      end

      def person_type
        RegisterBodsV2::PersonTypes['knownPerson'] # TODO: KNOWN_PERSON, ANONYMOUS_PERSON, UNKNOWN_PERSON
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
        psc_self_link_identifiers # TODO: include Register identifier
      end

      def unspecified_person_details
        #{
        #  reason,
        #  description
        #}
      end

      def names
        if data.name_elements.presence 
          [
            RegisterBodsV2::Name.new(
              type: RegisterBodsV2::NameTypes['individual'],
              fullName: name_string(data.name_elements),
              familyName: data.name_elements.surname,
              givenName: data.name_elements.forename,
              # patronymicName: nil
            )
          ]
        else
          [
            RegisterBodsV2::Name.new(
              type: RegisterBodsV2::NameTypes['individual'],
              fullName: data.name,
            )
          ]
        end
      end
      NAME_KEYS = %i[forename other_forenames surname].freeze # TODO: title?
      def name_string(name_elements)
        NAME_KEYS.map { |key| name_elements.send(key) }.map(&:presence).compact.join(' ')
      end

      def nationalities
        nationality = country_from_nationality(data.nationality).try(:alpha2)
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

      def place_of_birth
        # NOT IMPLEMENTED IN REGISTER
      end

      def birth_date
        dob_elements = entity_dob(data.date_of_birth)
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
        parts = [elements.year]
        parts << format('%02d', elements.month) if elements.month
        parts << format('%02d', elements.day) if elements.month && elements.day
        ISO8601::Date.new(parts.join('-'))
      end

      def death_date
        # NOT IMPLEMENTED IN REGISTER
      end

      def place_of_residence
        # NOT IMPLEMENTED IN REGISTER
        # TODO: SUGGESTION: data['country_of_residence'].presence,
      end

      def tax_residencies
        # NOT IMPLEMENTED IN REGISTER
      end

      ADDRESS_KEYS = %i[premises address_line_1 address_line_2 locality region postal_code].freeze
      def addresses
        return unless data.address.presence

        address = ADDRESS_KEYS.map { |key| data.address.send(key) }.map(&:presence).compact.join(', ')

        return [] if address.blank?

        country_of_residence = data.country_of_residence.presence
        country = try_parse_country_name_to_code(country_of_residence)

        return [] if country.blank? # TODO: check this

        [
          RegisterBodsV2::Address.new(
            type: RegisterBodsV2::AddressTypes['registered'], # TODO: check this
            address: address,
            # postCode: nil,
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

      def has_pep_status
        # NOT IMPLEMENTED IN REGISTER
      end

      def pep_status_details
        # NOT IMPLEMENTED IN REGISTER
      end
    end
  end
end    
