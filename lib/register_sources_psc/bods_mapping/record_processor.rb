require_relative 'interest_parser'

require 'register_sources_psc/enums/corporate_entity_kinds'
require 'register_sources_psc/enums/individual_kinds'
require 'register_sources_psc/enums/legal_person_kinds'
require 'register_sources_psc/enums/statement_kinds'
require 'register_sources_psc/enums/super_secure_kinds'

require 'register_sources_psc/bods_mapping/entity_statement'
require 'register_sources_psc/bods_mapping/person_statement'
require 'register_sources_psc/bods_mapping/child_entity_statement'
require 'register_sources_psc/bods_mapping/ownership_or_control_statement'

module RegisterSourcesPsc
  module BodsMapping
    class RecordProcessor
      def initialize(
        entity_resolver: nil,
        interest_parser: nil,
        person_statement_mapper: BodsMapping::PersonStatement,
        entity_statement_mapper: BodsMapping::EntityStatement,
        child_entity_statement_mapper: BodsMapping::ChildEntityStatement,
        ownership_or_control_statement_mapper: BodsMapping::OwnershipOrControlStatement,
      )
        @entity_resolver = entity_resolver
        @interest_parser = interest_parser || InterestParser.new
        @person_statement_mapper = person_statement_mapper
        @entity_statement_mapper = entity_statement_mapper
        @child_entity_statement_mapper = child_entity_statement_mapper
        @ownership_or_control_statement_mapper = ownership_or_control_statement_mapper
      end

      def process(psc_record)
        child_entity = map_child_entity(psc_record)
        parent_entity = map_parent_entity(psc_record)
        relationship = map_relationship(psc_record, child_entity, parent_entity)

        statements = [child_entity, parent_entity, relationship].compact
      end

      private

      attr_reader :entity_resolver, :interest_parser, :person_statement_mapper,
        :entity_statement_mapper, :child_entity_statement_mapper,
        :ownership_or_control_statement_mapper

      def map_child_entity(psc_record)
        BodsMapping::ChildEntityStatement.call(
          psc_record.company_number,
          entity_resolver: entity_resolver
        )
      end

      def map_parent_entity(psc_record)
        case psc_record.data.kind
        when IndividualKinds['individual-person-with-significant-control']
          person_statement_mapper.call(psc_record)
        when CorporateEntityKinds['corporate-entity-person-with-significant-control']
          entity_statement_mapper.call(psc_record, entity_resolver: entity_resolver)
        when LegalPersonKinds['legal-person-person-with-significant-control']
          entity_statement_mapper.call(psc_record, entity_resolver: entity_resolver)
        end
      end

      def map_relationship(psc_record, child_entity, parent_entity)
        return unless child_entity && parent_entity

        return unless [
          IndividualKinds['individual-person-with-significant-control'],
          CorporateEntityKinds['corporate-entity-person-with-significant-control'],
          LegalPersonKinds['legal-person-person-with-significant-control']
        ].include?(psc_record.data.kind)
        
        ownership_or_control_statement_mapper.call(
          psc_record,
          entity_resolver: entity_resolver,
          source_statement: parent_entity,
          target_statement: child_entity,
          interest_parser: interest_parser
        )
      end
    end
  end
end
