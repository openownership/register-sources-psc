require 'register_sources_psc/types'

require 'register_sources_psc/enums/restrictions_notices'
require 'register_sources_psc/enums/statement_descriptions'
require 'register_sources_psc/enums/statement_kinds'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class Statement < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :ceased_on, Types::Nominal::Date.optional
    attribute? :etag, Types::String.optional
    attribute? :kind, StatementKinds.optional
    attribute? :linked_psc_name, Types::String.optional
    attribute? :links, Links.optional
    attribute? :notified_on, Types::Nominal::Date.optional
    attribute? :restrictions_notice_withdrawal_reason, RestrictionsNotices.optional
    attribute? :statement, StatementDescriptions.optional
  end
end
