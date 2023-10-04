# frozen_string_literal: true

require_relative '../enums/descriptions'
require_relative '../enums/legal_person_beneficial_owner_kinds'
require_relative '../types'
require_relative 'address'
require_relative 'identification'
require_relative 'links'

module RegisterSourcesPsc
  class LegalPersonBeneficialOwner < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address,                  Address
    attribute? :ceased_on,                Types::Nominal::Date
    attribute? :etag,                     Types::String
    attribute? :identification,           Identification
    attribute? :is_sanctioned,            Types::Params::Bool
    attribute? :kind,                     LegalPersonBeneficialOwnerKinds
    attribute? :links,                    Links
    attribute? :name,                     Types::String
    attribute? :natures_of_control,       Types.Array(Descriptions).default([])
    attribute? :notified_on,              Types::Nominal::Date
    attribute? :principal_office_address, Address
  end
end
