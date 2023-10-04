# frozen_string_literal: true

require_relative '../enums/descriptions'
require_relative '../enums/individual_beneficial_owner_kinds'
require_relative '../types'
require_relative 'address'
require_relative 'date_of_birth'
require_relative 'links'
require_relative 'name_elements'

module RegisterSourcesPsc
  class IndividualBeneficialOwner < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address,                  Address
    attribute? :ceased_on,                Types::Nominal::Date
    attribute? :country_of_residence,     Types::String
    attribute? :date_of_birth,            DateOfBirth
    attribute? :etag,                     Types::String
    attribute? :is_sanctioned,            Types::Params::Bool
    attribute? :kind,                     IndividualBeneficialOwnerKinds
    attribute? :links,                    Links
    attribute? :name,                     Types::String
    attribute? :name_elements,            NameElements
    attribute? :nationality,              Types::String
    attribute? :natures_of_control,       Types.Array(Descriptions)
    attribute? :notified_on,              Types::Nominal::Date
    attribute? :principal_office_address, Address
  end
end
