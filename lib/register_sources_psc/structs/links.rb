# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  class Links < Dry::Struct
    transform_keys(&:to_sym)

    attribute  :self,      Types::String
    attribute? :statement, Types::String.optional
  end
end
