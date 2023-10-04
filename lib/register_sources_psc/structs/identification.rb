# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  class Identification < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :country_registered,  Types::String.optional
    attribute? :legal_authority,     Types::String.optional
    attribute? :legal_form,          Types::String.optional
    attribute? :place_registered,    Types::String.optional
    attribute? :registration_number, Types::String.optional
  end
end
