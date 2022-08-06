require 'register_sources_psc/types'

module RegisterSourcesPsc
  class NameElements < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :forename, Types::String.optional
    attribute? :other_forenames, Types::String.optional
    attribute? :surname, Types::String.optional
    attribute? :title, Types::String.optional
  end
end
