# frozen_string_literal: true

require 'register_sources_psc/types'

require 'register_sources_psc/enums/descriptions'
require 'register_sources_psc/enums/legal_person_kinds'
require 'register_sources_psc/structs/address'
require 'register_sources_psc/structs/identification'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class LegalPerson < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address, Address
    attribute? :ceased_on, Types::Nominal::Date
    attribute? :etag, Types::String
    attribute? :identification, Identification
    attribute? :kind, LegalPersonKinds
    attribute? :links, Links
    attribute? :name, Types::String
    attribute? :natures_of_control, Types.Array(Descriptions).default([])
    attribute? :notified_on, Types::Nominal::Date
  end
end
