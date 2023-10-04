# frozen_string_literal: true

require_relative '../enums/restrictions_notices'
require_relative '../enums/statement_descriptions'
require_relative '../enums/statement_kinds'
require_relative '../types'
require_relative 'links'

module RegisterSourcesPsc
  class Statement < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :ceased_on,                             Types::Nominal::Date
    attribute? :etag,                                  Types::String
    attribute? :kind,                                  StatementKinds
    attribute? :linked_psc_name,                       Types::String
    attribute? :links,                                 Links
    attribute? :notified_on,                           Types::Nominal::Date
    attribute? :restrictions_notice_withdrawal_reason, RestrictionsNotices
    attribute? :statement,                             StatementDescriptions
  end
end
