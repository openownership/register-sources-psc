require 'register_sources_psc/types'

module RegisterSourcesPsc
  class Identification < Dry::Struct
    attribute :country_registered, Types::String.optional.default(nil)
    attribute :legal_authority, Types::String.optional.default(nil)
    attribute :legal_form, Types::String.optional.default(nil)
    attribute :place_registered, Types::String.optional.default(nil)
    attribute :registration_number, Types::String.optional.default(nil)
  end
end
