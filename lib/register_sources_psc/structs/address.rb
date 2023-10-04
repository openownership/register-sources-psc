# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  class Address < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address_line_1, Types::String.optional # rubocop:disable Naming/VariableNumber
    attribute? :address_line_2, Types::String.optional # rubocop:disable Naming/VariableNumber
    attribute? :care_of,        Types::String.optional
    attribute? :country,        Types::String.optional
    attribute? :locality,       Types::String.optional
    attribute? :postal_code,    Types::String.optional
    attribute? :premises,       Types::String.optional
    attribute? :region,         Types::String.optional
  end
end
