require 'register_sources_psc/struct/resolver_details'

module RegisterSourcesPsc
  module Services
    class OcResolver
      ResolvedRecord = Struct.new(:psc_record, :resolver_details)

      def initialize(oc_company_service: nil)
        @oc_company_service = oc_company_service || RegisterSourcesOc::Services::CompanyService.new
      end

      def resolve(psc_records)
        psc_records.map do |psc_record|
          resolver_details = resolve_record(psc_record)
          ResolvedRecord.new(psc_record, resolver_details)
        end
      end

      private

      attr_reader :oc_company_service

      def resolve_record(psc_record)
        ResolverDetails.new(
          jurisdiction_code: jurisdiction_code(psc_record),
          company_number: company_number(psc_record),
          country: country(psc_record),
          name: name(psc_record)
        )
      end

      def jurisdiction_code(psc_record)
        # child_entity: 'gb'
        # parent_entity: nil (resolve from country)
      end

      def company_number(psc_record)
        # child_entity: record['company_number']
        # parent_entity
      end

      def country(psc_record)
        # child_entity: nil
        # parent_entity:
        #   - corporate_entity: data['identification']['country_registered']
        # ignore legal_person, individual_person
      end

      def name(psc_record)
        # child_entity: nil
      end

      def resolve_jurisdiction_code(resolver_details)
        return if resolver_details.jurisdiction_code.present?

        country = resolver_details.country
        return unless country.present?

        jurisdiction_code = cache_adapter.with_cache(country) do
          opencorporates_client.get_jurisdiction_code country
        end

        resolver_details.add_jurisdiction_code jurisdiction_code
      end

      def resolve_company_number(resolver_details)
        company_number_response = reconciliation_client.reconcile(
          resolver_details.jurisdiction_code,
          resolver_details.attributes[:name]
        )

        resolver_details.add_company_number_response company_number_response
      end

      def resolve_company_details(resolver_details)
        company_details_response = opencorporates_client.get_company(
          resolver_details.jurisdiction_code,
          resolver_details.company_number
        )
        resolver_details.add_company_details_response company_details_response

        if !company_details_response
          company_list_response = opencorporates_client.search_companies(
            resolver_details.jurisdiction_code,
            resolver_details.company_number
          )
          resolver_details.add_company_list_response company_list_response
        end
      end
    end
  end
end
