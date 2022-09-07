require 'xxhash'
require 'register_bods_v2/constants/publisher'
require 'register_bods_v2/structs/publication_details'
require 'register_bods_v2/structs/source'

module RegisterSourcesPsc
  module BodsMapping
    class BaseStatement
      ID_PREFIX = 'openownership-register-'.freeze

      def initialize(resolved_record)
        @resolved_record = resolved_record
        @identifier_builder = nil
      end

      # def call

      private

      attr_reader :resolved_record, :identifier_builder

      def data
        resolved_record.psc_record.data
      end

      def company_details
        resolved_record.resolver_details.company_details
      end

      def statementDate
        # UNIMPLEMENTED IN REGISTER (only for ownership or control statements)
      end

      def isComponent
        false
      end

      def replacesStatements
        # UNIMPLEMENTED IN REGISTER
      end

      def publicationDetails
        # UNIMPLEMENTED IN REGISTER
        RegisterBodsV2::PublicationDetails.new(
          publicationDate: Time.now.utc,
          bodsVersion: BODS_VERSION,
          license: BODS_LICENSE,
          publisher: PUBLISHER
        )
      end

      def source
        # UNIMPLEMENTED IN REGISTER
        # implemented for relationships
        RegisterBodsV2::Source.new(
          type: RegisterBodsV2::SourceTypes['officialRegister'],
          description: 'GB Persons Of Significant Control Register',=
          url: "http://download.companieshouse.gov.uk/en_pscdata.html", # TODO: link to snapshot?
          retrievedAt: Time.now.utc, # TODO: add retrievedAt to record iso8601
          assertedBy: nil # TODO: if it is a combination of sources (PSC and OpenCorporates), is it us?
        )
      end

      def annotations
        # UNIMPLEMENTED IN REGISTER
      end

      def replacesStatements
        # UNIMPLEMENTED IN REGISTER
      end

      def hasher(data)
        XXhash.xxh64(data).to_s
      end
    end
  end
end
