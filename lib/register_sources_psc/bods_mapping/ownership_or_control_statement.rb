require 'register_bods_v2/structs/interest'
require 'register_bods_v2/structs/ownership_or_control_statement'
require 'register_bods_v2/structs/share'
require 'register_bods_v2/constants/publisher'
require 'register_bods_v2/structs/publication_details'
require 'register_bods_v2/structs/source'
require 'register_bods_v2/structs/subject'

require_relative 'interest_parser'

module RegisterSourcesPsc
  module BodsMapping
    class OwnershipOrControlStatement
      def self.call(psc_record, **kwargs)
        new(psc_record, **kwargs).call
      end

      def initialize(
        psc_record,
        entity_resolver: nil,
        source_statement: nil,
        target_statement: nil,
        interest_parser: nil
      )
        @psc_record = psc_record
        @source_statement = source_statement
        @target_statement = target_statement
        @interest_parser = interest_parser || InterestParser.new
        @entity_resolver = entity_resolver
      end

      def call
        RegisterBodsV2::OwnershipOrControlStatement[{
          statementID: statement_id,
          statementType: statement_type,
          statementDate: statement_date,
          isComponent: false,
          # componentStatementIDs: component_statement_ids,
          subject: subject,
          interestedParty: interested_party,
          interests: interests,
          publicationDetails: publication_details,
          source: source,
          # annotations: annotations,
          # replacesStatements: replaces_statements
        }.compact]
      end

      private

      attr_reader :interest_parser, :entity_resolver, :source_statement, :target_statement

      def statement_id #when Structs::Relationship
        ID_PREFIX + hasher(
          {
            id: obj.id,
            updated_at: obj.updated_at,
            source_id: source_statement.statementID,
            target_id: target_statement.statementID,
          }.to_json
        )
      end

      def statement_type
        RegisterBodsV2::StatementTypes['ownershipOrControlStatement']
      end

      def statement_date
        data.notified_on.presence.try(:to_s) # ISO8601::Date
      end

      def subject
        RegisterBodsV2::Subject.new(
          describedByEntityStatement: target_statement.statementID
        )
      end

      def interested_party
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
        (data.natures_of_control || []).map do |i|
          entry = interest_parser.call(i)  
          share = entry.fetch(:share, {})

          RegisterBodsV2::Interest[{
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
            startDate: data.notified_on.presence.try(:to_s),
            endDate: data.ceased_on.presence.try(:to_s)
          }.compact]
        end
      end

      def source
        
      end
      def ocs_source(relationship, imports)
        return ocs_source_from_raw_data(relationship, imports) unless relationship.import_ids.empty?
        
        provenance = relationship.provenance
        return if provenance.blank?
        return unless SOURCE_TYPES_MAP.key?(provenance.source_name)

        {
          type:        SOURCE_TYPES_MAP[provenance.source_name],
          description: SOURCE_NAMES_MAP.fetch(provenance.source_name, provenance.source_name),
          url:         provenance.source_url.presence,
          retrievedAt: provenance.retrieved_at.iso8601,
        }.compact
      end

      def ocs_source_from_raw_data(relationship, imports)
        imports = relationship.import_ids.map { |import_id| imports[import_id.to_s] }.compact
        raise EmptyImportsError if imports.empty?

        if imports.map(&:data_source_id).uniq.length > 1
          raise "[#{self.class.name}] Relationship: #{relationship.id} comes from multiple data sources, can't produce a single Source for it"
        end

        most_recent_import = imports.max_by(&:created_at)
        data_source = most_recent_import.data_source

        {
          type:        data_source.types,
          description: SOURCE_NAMES_MAP.fetch(data_source.name, data_source.name),
          url:         data_source.url,
          retrievedAt: most_recent_import.created_at.iso8601,
        }.compact
      end
    end
  end
end
