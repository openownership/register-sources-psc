require 'register_bods_v2/structs/identifier'

module RegisterSourcesPsc
  module BodsMapping
    class EntityStatementIdentifiers
      OPEN_CORPORATES_SCHEME_NAME = 'OpenCorporates'

      def initialize(psc_record)
        @psc_record = psc_record
      end

      def build(opencorporates: false)
        opencorporates_id = nil # opencorporates ? opencorporates_identifier : nil

        psc_self_link_identifiers + [opencorporates_id, register_identifier].compact
      end

      private

      attr_reader :psc_record

      def data
        @data ||= psc_record.data
      end

      def opencorporates_identifier(identifier) # get from resolver_details
        # TODO: only include if resolved
        jurisdiction = identifier['jurisdiction_code']
        number = identifier['company_number']

        RegisterBodsV2::Identifier.new(
          id: oc_url,
          # scheme: nil,
          schemeName: OPEN_CORPORATES_SCHEME_NAME,
          uri: "https://opencorporates.com/companies/#{jurisdiction}/#{number}"
        )
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
        identifier_link = data.links.self
        return unless identifier_link.present?

        company_number = data.identification.registration_number

        identifiers = [
          RegisterBodsV2::Identifier.new(
            id: identifier_link,
            # scheme: nil,
            schemeName: DOCUMENT_ID,
            # uri: nil
          )
        ]
        if company_number.present? # this depends on if corporate entity
          identifiers << RegisterBodsV2::Identifier.new(
            id: company_number,
            # scheme: nil,
            schemeName: "#{DOCUMENT_ID} - Registration numbers",
            # uri: nil # uri
          )
        end
        identifiers
      end

      def register_identifier
        RegisterBodsV2::Identifier.new(
          id: url,
          # scheme: nil,
          schemeName: 'OpenOwnership Register',
          uri: URI.join(url_base, "/entities/#{entity.id}").to_s
        )
      end

      def url_base
        '/' # TODO: use ENV variable?
      end
    end
  end
end
