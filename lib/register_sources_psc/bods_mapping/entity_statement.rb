require 'register_bods_v2/enums/entity_types'
require 'register_bods_v2/enums/statement_types'
require 'register_bods_v2/structs/address'
require 'register_bods_v2/structs/entity_statement'
require 'register_bods_v2/structs/jurisdiction'
require 'register_bods_v2/constants/publisher'
require_relative 'base_statement'

module RegisterSourcesPsc
  module BodsMapping
    class EntityStatement < BaseStatement
      ID_PREFIX = 'openownership-register-'.freeze

      def call
        RegisterBodsV2::EntityStatement.new(
          statementID: statementID,
          statementType: statementType,
          statementDate: statementDate,
          isComponent: isComponent,
          entityType: entityType,
          unspecifiedEntityDetails: unspecifiedEntityDetails,
          name: name,
          alternateNames: alternateNames,
          incorporatedInJurisdiction: incorporatedInJurisdiction,
          identifiers: identifiers,
          foundingDate: foundingDate,
          dissolutionDate: dissolutionDate,
          addresses: addresses,
          uri: uri,
          replacesStatements: replacesStatements,
          publicationDetails: publicationDetails,
          source: source,
          annotations: annotations
        )
      end

      private

      attr_reader :resolved_record, :identifier_builder

      def data
        @data ||= resolved_record.raw_data_record.parsed_raw_data['data']
      end

      def company_details
        @company_details ||= resolved_record.resolver_details.company_details
      end

      def statementID
        # NO LONGER DEPENDS ON MONGO - UNSTABLE - MATCH OLD RECORDS?
        id = register_entity_id # TODO: implement
        self_updated_at = publicationDetails.publicationDate # TODO: use statement retrievedAt?
        ID_PREFIX + hasher("openownership-register/entity/#{id}/#{self_updated_at}")
      end

      def statementType
        RegisterBodsV2::StatementTypes['entityStatement']
      end

      def entityType
         # TODO: Legacy - this is hard-coded to registeredEntity in exporter
        RegisterBodsV2::EntityTypes['registeredEntity']
      end

      def identifiers
        identifier_builder.build resolved_record
      end

      def unspecifiedEntityDetails
        # { reason, description }
        # UNIMPLEMENTED IN REGISTER
      end

      def name
        data['name']
      end

      def alternateNames
        # UNIMPLEMENTED IN REGISTER
      end

      def incorporatedInJurisdiction
        jurisdiction_code = resolved_record.resolver_details.jurisdiction_code
        return unless jurisdiction_code
      
        code, = jurisdiction_code.split('_')
        country = ISO3166::Country[code]
        return nil if country.blank?
        Bods::Jurisdiction.new(
          name: country.name,
          code: country.alpha2,
        )
      end

      def identifiers
        identifier_builder.build resolved_record
      end

      def foundingDate
        date = company_details[:incorporation_date]&.to_date
        return unless date
        date.try(:iso8601)
      rescue Date::Error
        LOGGER.warn "Entity has invalid incorporation_date: #{date}"
        nil
      end

      def dissolutionDate
        date = company_details[:dissolution_date]&.to_date
        return unless date
        date.try(:iso8601)
      rescue Date::Error
        LOGGER.warn "Entity has invalid dissolution_date: #{date}"
        nil
      end

      ADDRESS_KEYS = %w[premises address_line_1 address_line_2 locality region postal_code].freeze
      def addresses
        return [] unless data['address'].presence

        address = data['address'].values_at(*ADDRESS_KEYS).map(&:presence).compact.join(', ')
        return [] if address.blank?

        incorporated_in_jurisdiction = incorporatedInJurisdiction
        country_code =
          incorporated_in_jurisdiction ? incorporated_in_jurisdiction[:code] : nil

        [
          RegisterBodsV2::Address.new(
            type: RegisterBodsV2::AddressTypes['registered'],
            address: address,
            postcode: nil,
            country: country_code
          )
        ]
      end

      def uri
        # UNIMPLEMENTED IN REGISTER
      end
    end
  end
end
