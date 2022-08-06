require 'register_sources_psc/types'

require 'register_sources_psc/enums/descriptions'
require 'register_sources_psc/enums/legal_person_kinds'
require 'register_sources_psc/structs/address'
require 'register_sources_psc/structs/identification'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class LegalPerson < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address, Address.optional
    attribute? :ceased_on, Types::Nominal::Date.optional
    attribute? :etag, Types::String
    attribute? :identification, Identification.optional
    attribute? :kind, LegalPersonKinds.optional
    attribute? :links, Links.optional
    attribute? :name, Types::String.optional
    attribute? :natures_of_control, Types.Array(Descriptions).default([])
    attribute? :notified_on, Types::Nominal::Date.optional
  end
end
