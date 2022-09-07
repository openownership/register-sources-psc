require 'register_sources_psc/types'

module RegisterSourcesPsc
  class ResolverDetails < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :jurisdiction_code, Types::String.optional
    attribute? :company_number, Types::String.optional
    attribute? :country, Types::String.optional
    attribute? :name, Types::String.optional
  end
end
