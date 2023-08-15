require 'register_sources_psc/types'

module RegisterSourcesPsc
  class Address < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address_line_1, Types::String.optional
    attribute? :address_line_2, Types::String.optional
    attribute? :care_of, Types::String.optional
    attribute? :country, Types::String.optional
    attribute? :locality, Types::String.optional
    attribute? :postal_code, Types::String.optional
    attribute? :premises, Types::String.optional
    attribute? :region, Types::String.optional
  end
end
