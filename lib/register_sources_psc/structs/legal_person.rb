require 'register_sources_psc/types'

require 'register_sources_psc/enums/descriptions'
require 'register_sources_psc/enums/legal_person_kinds'
require 'register_sources_psc/structs/address'
require 'register_sources_psc/structs/identification'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class LegalPerson < Dry::Struct
    transform_keys(&:to_sym)

    attribute :address, Address.optional.default(nil)
    attribute :ceased_on, Types::Nominal::Date.optional.default(nil)
    attribute :etag, Types::String.optional.default(nil)
    attribute :identification, Identification.optional.default(nil)
    attribute :kind, LegalPersonKinds.optional.default(nil)
    attribute :links, Links.optional.default(nil)
    attribute :name, Types::String.optional.default(nil)
    attribute :natures_of_control, Types.Array(Descriptions).default([])
    attribute :notified_on, Types::Nominal::Date.optional.default(nil)
  end
end
