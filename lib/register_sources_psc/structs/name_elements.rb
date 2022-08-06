require 'register_sources_psc/types'

module RegisterSourcesPsc
  class NameElements < Dry::Struct
    transform_keys(&:to_sym)

    attribute :forename, Types::String.optional.default(nil)
    attribute :other_forenames, Types::String.optional.default(nil)
    attribute :surname, Types::String.optional.default(nil)
    attribute :title, Types::String.optional.default(nil)
  end
end
