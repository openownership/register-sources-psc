require 'register_sources_psc/enums/individual_kinds'
require 'register_sources_psc/bods_mapping/entity_statement'
require 'register_sources_psc/bods_mapping/person_statement'

module RegisterSourcesPsc
  module BodsMapping
    class RecordProcessor
      def process(psc_record)
        mapper = select_mapper(psc_record)

        return unless mapper

        mapper.new(psc_record).call
      end

      private

      def select_mapper(psc_record)
        case psc_record.data.kind
        when IndividualKinds['individual-person-with-significant-control']:
          BodsMapping::PersonStatement
        end
      end
    end
  end
end
