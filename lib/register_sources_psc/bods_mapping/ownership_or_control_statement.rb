require 'register_bods_v2/structs/interest'
require 'register_bods_v2/structs/ownership_or_control_statement'
require 'register_bods_v2/structs/share'
require_relative 'base_statement'
require_relative 'interest_parser'

module RegisterSourcesPsc
  module BodsMapping
    class OwnershipOrControlStatement < BaseStatement
      def call(resolved_record, source_statement, target_statement)
        RegisterBodsV2::OwnershipOrControlStatement.new(
          statementID: statementID,
          statementType: statementType,
          statementDate: statementDate,
          isComponent: isComponent,
          componentStatementIDs: componentStatementIDs,
          subject: subject,
          interestedParty: interestedParty,
          interests: interests,
          publicationDetails: publicationDetails,
          source: source,
          annotations: annotations,
          replacesStatements: replacesStatements
        )
      end

      private

      def interest_parser
        @interest_parser ||= InterestParser.new
      end

      def statementID
        #when Structs::Relationship
        #  things_that_make_relationship_statements_unique = {
        #    id: obj.id,
        #    updated_at: obj.updated_at,
        #    source_id: statement_id(obj.source),
        #    target_id: statement_id(obj.target),
        #  }
        #  ID_PREFIX + hasher(things_that_make_relationship_statements_unique.to_json)
        #when Structs::Statement
        #  things_that_make_psc_statement_statements_unique = {
        #    id: obj.id,
        #    updated_at: obj.updated_at,
        #    entity_id: statement_id(obj.entity),
        #  }
        #  ID_PREFIX + hasher(things_that_make_psc_statement_statements_unique.to_json)
      end

      def statementType
        RegisterBodsV2::StatementTypes['ownershipOrControlStatement']
      end

      def statementDate
        data['notified_on'].presence.try(:to_s) # ISO8601::Date
      end

      def componentStatementIDs
        nil
      end

      def subject
        RegisterBodsV2::Subject.new(
          describedByEntityStatement: statement_id(target)
        )
        # NOT IMPLEMENTED
      end

      def interestedParty
        # NOT IMPLEMENTED
      end
      #def ocs_interested_party(relationship)
      #  source = relationship.source

      #  case source
      #  when Structs::UnknownPersonsEntity
      #    source_unspecified_reason = ocs_unspecified_reason(source)
      #    if source_unspecified_reason.present?
      #      {
      #        unspecified: {
      #          reason:      source_unspecified_reason,
      #          description: source.name,
      #        },
      #      }
      #    else
      #      {
      #        describedByPersonStatement: statement_id(source),
      #      }
      #    end
      #  when Structs::Entity
      #    {
      #      describedByEntityStatement: source.legal_entity? ? statement_id(source) : nil,
      #      describedByPersonStatement: source.natural_person? ? statement_id(source) : nil,
      #    }.compact
      #  end
      #end
      #def ocs_unspecified_reason(unknown_person)
      #  return if statement_id_calculator.generates_statement?(unknown_person)
      #  case unknown_person.unknown_reason_code
      #  when 'no-individual-or-entity-with-signficant-control',
      #       'no-individual-or-entity-with-signficant-control-partnership'
      #    'no-beneficial-owners'
      #  when 'disclosure-transparency-rules-chapter-five-applies',
      #       'psc-exempt-as-trading-on-regulated-market',
      #       'psc-exempt-as-shares-admitted-on-market'
      #    'subject-exempt-from-disclosure'
      #  else # 'steps-to-find-psc-not-yet-completed', 'steps-to-find-psc-not-yet-completed-partnership'
      #    'unknown'
      #  end
      #end

      def interests
        (data['natures_of_control'] || []).map do |i|
          entry = interest_parser.call(i)  
          share = entry.fetch(:share, {})

          RegisterBodsV2::Interest.new(
            type: entry[:type],
            interestLevel: nil,
            beneficialOwnershipOrControl: nil,
            details: entry[:details],
            RegisterBodsV2::Share.new(
              exact: share[:exact],
              maximum: share[:maximum],
              minimum: share[:minimum],
              exclusiveMinimum: share[:exclusiveMinimum],
              exclusiveMaximum: share[:exclusiveMaximum],
            ),
            startDate: data['notified_on'].presence.try(:to_s),
            endDate: data['ceased_on'].presence.try(:to_s)
          )
        end
      end

      def source
        # relationship source
        raise 'implement'
      end
      # entity or person statement

      def target
        # relationship target
        raise 'implement'
      end
      # child_entity
      # company_number = record['company_number']
      #Structs::RegisterEntity.new(
      #  attributes: {
      #    identifiers: [
      #      {
      #        'document_id'    => datasource.document_id,
      #        'company_number' => company_number
      #      }
      #    ],
      #    type:              EntityTypes::LEGAL_ENTITY,
      #    jurisdiction_code: 'gb',
      #    company_number:    company_number
      #  }
      #)
    end
  end
end
