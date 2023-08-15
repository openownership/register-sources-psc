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

    attribute? :address, Address
    attribute? :ceased_on, Types::Nominal::Date
    attribute? :country_of_residence, Types::String
    attribute? :date_of_birth, DateOfBirth
    attribute? :etag, Types::String
    attribute? :kind, IndividualKinds
    attribute? :links, Links
    attribute? :name, Types::String
    attribute? :name_elements, NameElements
    attribute? :nationality, Types::String
    attribute? :natures_of_control, Types.Array(Descriptions)
    attribute? :notified_on, Types::Nominal::Date
  end
end
