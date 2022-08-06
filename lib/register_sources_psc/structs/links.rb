require 'register_sources_psc/types'

module RegisterSourcesPsc
  class Links < Dry::Struct
    transform_keys(&:to_sym)

    attribute :self, Types::String
    attribute? :statement, Types::String.optional
  end
end
