module RegisterSourcesPsc
  module Services
    class BodsV2Mapper
      def initialize(oc_resolver: nil)
        @oc_resolver = oc_resolver
      end

      def map_records(records)
        oc_records = oc_resolver.resolve records

        
      end

      private

      attr_reader :oc_resolver
    end
  end
end
