require 'xxhash'
require 'register_bods_v2/constants/publisher'
require 'register_bods_v2/structs/publication_details'
require 'register_bods_v2/structs/source'

module RegisterSourcesPsc
  module BodsMapping
    class BaseStatement
      ID_PREFIX = 'openownership-register-'.freeze

      def initialize(psc_record)
        @psc_record = psc_record
      end

      # def call

      private

      attr_reader :psc_record

      def data
        psc_record.data
      end

      def statement_date
        # UNIMPLEMENTED IN REGISTER (only for ownership or control statements)
      end

      def is_component
        false
      end

      def replaces_statements
        # UNIMPLEMENTED IN REGISTER
      end

      def publication_details
        # UNIMPLEMENTED IN REGISTER
        RegisterBodsV2::PublicationDetails.new(
          publicationDate: Time.now.utc.to_date.to_s, # TODO: fix publication date
          bodsVersion: RegisterBodsV2::BODS_VERSION,
          license: RegisterBodsV2::BODS_LICENSE,
          publisher: RegisterBodsV2::PUBLISHER
        )
      end

      def source
        # UNIMPLEMENTED IN REGISTER
        # implemented for relationships
        RegisterBodsV2::Source.new(
          type: RegisterBodsV2::SourceTypes['officialRegister'],
          description: 'GB Persons Of Significant Control Register',
          url: "http://download.companieshouse.gov.uk/en_pscdata.html", # TODO: link to snapshot?
          retrievedAt: Time.now.utc.to_date.to_s, # TODO: fix publication date, # TODO: add retrievedAt to record iso8601
          assertedBy: nil # TODO: if it is a combination of sources (PSC and OpenCorporates), is it us?
        )
      end

      def annotations
        # UNIMPLEMENTED IN REGISTER
      end

      def replaces_statements
        # UNIMPLEMENTED IN REGISTER
      end

      # When we import PSC data containing RLEs (intermediate company owners) we
      # give them a weird three-part identifier including their company number and
      # the original identifier from the data called a "self link". When we output
      # this we want to output two BODS identifiers, one for the link and one for the
      # company number. This allows us to a) link the statement back to the specific
      # parts of the PSC data it came from and b) share the company number we
      # figured out from an OC lookup, but make the provenance clearer.
      DOCUMENT_ID = 'GB Persons Of Significant Control Register'
      def psc_self_link_identifiers # if entity.legal_entity?
        identifier_link = data.links[:self]
        return unless identifier_link.present?
        
        identifiers = [
          RegisterBodsV2::Identifier.new(
            id: identifier_link,
            schemeName: DOCUMENT_ID,
          )
        ]

        return identifiers unless data.respond_to?(:identification)

        company_number = data.identification.registration_number
        if company_number.present? # this depends on if corporate entity
          identifiers << RegisterBodsV2::Identifier.new(
            id: company_number,
            schemeName: "#{DOCUMENT_ID} - Registration numbers",
          )
        end
        identifiers
      end

      # TODO!
      def register_identifier
        RegisterBodsV2::Identifier.new(
          id: url,
          schemeName: 'OpenOwnership Register',
          uri: URI.join(url_base, "/entities/#{entity.id}").to_s
        )
      end

      def hasher(data)
        XXhash.xxh64(data).to_s
      end
    end
  end
end
