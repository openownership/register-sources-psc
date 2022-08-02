require 'register_sources_psc/enums/corporate_entity_kinds'
require 'register_sources_psc/enums/descriptions'
require 'register_sources_psc/structs/address'
require 'register_sources_psc/structs/identification'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class CorporateEntity < Dry::Struct
    attribute :address, Address
    attribute :ceased_on, Types::Nominal::Date.optional.default(nil)
    attribute :etag, Types::String
    attribute :identification, Identification
    attribute :kind, CorporateEntityKinds
    attribute :links, Links
    attribute :name, Types::String
    attribute :natures_of_control, Types.Array(Descriptions)
    attribute :notified_on, Types::Nominal::Date
  end
end
