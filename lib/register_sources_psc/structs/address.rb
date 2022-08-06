require 'register_sources_psc/types'

module RegisterSourcesPsc
  class Address < Dry::Struct
    transform_keys(&:to_sym)

    attribute :address_line_1, Types::String.optional.default(nil)
    attribute :address_line_2, Types::String.optional.default(nil)
    attribute :care_of, Types::String.optional.default(nil)
    attribute :country, Types::String.optional.default(nil)
    attribute :locality, Types::String.optional.default(nil)
    attribute :postal_code, Types::String.optional.default(nil)
    attribute :premises, Types::String.optional.default(nil)
    attribute :region, Types::String.optional.default(nil)
  end
end
