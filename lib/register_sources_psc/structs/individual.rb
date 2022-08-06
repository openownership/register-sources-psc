require 'register_sources_psc/types'

require 'register_sources_psc/enums/descriptions'
require 'register_sources_psc/enums/individual_kinds'
require 'register_sources_psc/structs/address'
require 'register_sources_psc/structs/date_of_birth'
require 'register_sources_psc/structs/links'
require 'register_sources_psc/structs/name_elements'

module RegisterSourcesPsc
  class Individual < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address, Address.optional
    attribute? :ceased_on, Types::Nominal::Date.optional
    attribute? :country_of_residence, Types::String.optional
    attribute? :date_of_birth, DateOfBirth.optional
    attribute? :etag, Types::String
    attribute? :kind, IndividualKinds.optional
    attribute? :links, Links.optional
    attribute? :name, Types::String.optional
    attribute? :name_elements, NameElements.optional
    attribute? :nationality, Types::String.optional
    attribute? :natures_of_control, Types.Array(Descriptions)
    attribute? :notified_on, Types::Nominal::Date.optional
  end
end
