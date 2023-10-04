# frozen_string_literal: true

require_relative '../enums/corporate_entity_kinds'
require_relative '../enums/descriptions'
require_relative '../types'
require_relative 'address'
require_relative 'identification'
require_relative 'links'

module RegisterSourcesPsc
  class CorporateEntity < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :address,            Address
    attribute? :ceased_on,          Types::Nominal::Date
    attribute? :etag,               Types::String
    attribute? :identification,     Identification
    attribute? :kind,               CorporateEntityKinds
    attribute? :links,              Links
    attribute? :name,               Types::String
    attribute? :natures_of_control, Types.Array(Descriptions)
    attribute? :notified_on,        Types::Nominal::Date
  end
end
