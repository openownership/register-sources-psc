# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  class DateOfBirth < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :day,   Types::Nominal::Integer
    attribute  :month, Types::Nominal::Integer
    attribute  :year,  Types::Nominal::Integer
  end
end
