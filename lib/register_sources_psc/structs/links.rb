require 'register_sources_psc/types'

module RegisterSourcesPsc
  class Links < Dry::Struct
    attribute :self, Types::String
    attribute :statement, Types::String.optional.default(nil)
  end
end
