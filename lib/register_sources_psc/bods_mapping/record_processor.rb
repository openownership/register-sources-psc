require 'register_sources_psc/enums/individual_kinds'
require 'register_sources_psc/bods_mapping/entity_statement'
require 'register_sources_psc/bods_mapping/person_statement'

module RegisterSourcesPsc
  module BodsMapping
    class RecordProcessor
      def process(resolved_record)
        mapper = select_mapper(resolved_record)

        return unless mapper

        mapper.new(resolved_record).call
      end

      private

      def select_mapper(resolved_record)
        case resolved_record.psc_record.data.kind
        when IndividualKinds['individual-person-with-significant-control']:
          BodsMapping::PersonStatement
        end
      end
    end
  end
end
