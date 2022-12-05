require 'register_sources_psc/types'

require 'register_sources_psc/enums/descriptions'
require 'register_sources_psc/enums/individual_beneficial_owner_kinds'
require 'register_sources_psc/structs/address'
require 'register_sources_psc/structs/date_of_birth'
require 'register_sources_psc/structs/links'
require 'register_sources_psc/structs/name_elements'

module RegisterSourcesPsc
  class IndividualBeneficialOwner < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address, Address
    attribute? :ceased_on, Types::Nominal::Date
    attribute? :country_of_residence, Types::String
    attribute? :date_of_birth, DateOfBirth
    attribute? :etag, Types::String
    attribute? :is_sanctioned, Types::Params::Bool
    attribute? :kind, IndividualBeneficialOwnerKinds
    attribute? :links, Links
    attribute? :name, Types::String
    attribute? :name_elements, NameElements
    attribute? :nationality, Types::String
    attribute? :natures_of_control, Types.Array(Descriptions)
    attribute? :notified_on, Types::Nominal::Date
    attribute? :principal_office_address, Address
  end
end
