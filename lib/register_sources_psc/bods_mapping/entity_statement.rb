require 'register_bods_v2/enums/entity_types'
require 'register_bods_v2/enums/statement_types'
require 'register_bods_v2/structs/address'
require 'register_bods_v2/structs/entity_statement'
require 'register_bods_v2/structs/jurisdiction'
require 'register_bods_v2/constants/publisher'

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/time'
require 'active_support/core_ext/string/conversions'

require 'register_sources_oc/structs/resolver_request'

require_relative 'base_statement'

module RegisterSourcesPsc
  module BodsMapping
    class EntityStatement < BaseStatement
      ID_PREFIX = 'openownership-register-'.freeze

      def call
        RegisterBodsV2::EntityStatement[{
          statementID: statement_id,
          statementType: statement_type,
          statementDate: statement_date,
          isComponent: is_component,
          entityType: entity_type,
          unspecifiedEntityDetails: unspecified_entity_details,
          name: name,
          alternateNames: alternate_names,
          incorporatedInJurisdiction: incorporated_in_jurisdiction,
          identifiers: identifiers,
          foundingDate: founding_date,
          dissolutionDate: dissolution_date,
          addresses: addresses,
          uri: uri,
          replacesStatements: replaces_statements,
          publicationDetails: publication_details,
          source: source,
          annotations: annotations
        }.compact]
      end

      private

      attr_reader :psc_record

      def resolver_response
        return @resolver_response if @resolver_response

        # TODO: this is for corporate entities
        @resolver_response = entity_resolver.resolve(
          RegisterSourcesOc::ResolverRequest.new(
            company_number: data.identification.registration_number,
            country: data.identification.country_registered,
            name: data.name,
          )
        )
      end

      def statement_id
        # NO LONGER DEPENDS ON MONGO - UNSTABLE - MATCH OLD RECORDS?
        id = 'register_entity_id' # TODO: implement
        self_updated_at = publication_details.publicationDate # TODO: use statement retrievedAt?
        ID_PREFIX + hasher("openownership-register/entity/#{id}/#{self_updated_at}")
      end

      def statement_type
        RegisterBodsV2::StatementTypes['entityStatement']
      end

      def entity_type
         # TODO: Legacy - this is hard-coded to registeredEntity in exporter
        RegisterBodsV2::EntityTypes['registeredEntity']
      end

      def identifiers
        psc_self_link_identifiers # add oc identifiers
      end

      def unspecified_entity_details
        # { reason, description }
        # UNIMPLEMENTED IN REGISTER
      end

      def name
        data.name
      end

      def alternate_names
        # UNIMPLEMENTED IN REGISTER
      end

      def incorporated_in_jurisdiction
        jurisdiction_code = resolver_response.jurisdiction_code
        return unless jurisdiction_code
      
        code, = jurisdiction_code.split('_')
        country = ISO3166::Country[code]
        return nil if country.blank?

        Bods::Jurisdiction.new(name: country.name, code: country.alpha2)
      end

      def identifiers
        [] #TODO: identifier_builder.build psc_record
      end

      def founding_date
        return unless resolver_response.company
        date = resolver_response.company.incorporation_date&.to_date
        return unless date
        date.try(:iso8601)
      rescue Date::Error
        LOGGER.warn "Entity has invalid incorporation_date: #{date}"
        nil
      end

      def dissolution_date
        return unless resolver_response.company
        date = resolver_response.company.dissolution_date&.to_date
        return unless date
        date.try(:iso8601)
      rescue Date::Error
        LOGGER.warn "Entity has invalid dissolution_date: #{date}"
        nil
      end

      ADDRESS_KEYS = %i[premises address_line_1 address_line_2 locality region postal_code].freeze
      def addresses
        return [] unless data.address.presence

        address = ADDRESS_KEYS.map { |key| data.address.send(key) }.map(&:presence).compact.join(', ')
        return [] if address.blank?

        country_code = incorporated_in_jurisdiction ? incorporated_in_jurisdiction.code : nil

        [
          RegisterBodsV2::Address[{
            type: RegisterBodsV2::AddressTypes['registered'],
            address: address,
            postcode: data.address.postal_code,
            country: country_code
          }.compact]
        ]
      end

      def uri
        # UNIMPLEMENTED IN REGISTER
      end
    end
  end
end
