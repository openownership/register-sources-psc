require 'register_sources_psc/types'

require 'register_sources_psc/enums/restrictions_notices'
require 'register_sources_psc/enums/statement_descriptions'
require 'register_sources_psc/enums/statement_kinds'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class Statement < Dry::Struct
    attribute :ceased_on, Types::Nominal::Date.optional.default(nil)
    attribute :etag, Types::String.optional.default(nil)
    attribute :kind, StatementKinds.optional.default(nil)
    attribute :linked_psc_name, Types::String.optional.default(nil)
    attribute :links, Links.optional.default(nil)
    attribute :notified_on, Types::Nominal::Date.optional.default(nil)
    attribute :restrictions_notice_withdrawal_reason, RestrictionsNotices.optional.default(nil)
    attribute :statement, StatementDescriptions.optional.default(nil)
  end
end
