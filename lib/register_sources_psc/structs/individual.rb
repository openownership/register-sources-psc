require 'register_sources_psc/types'

require 'register_sources_psc/enums/descriptions'
require 'register_sources_psc/enums/individual_kinds'
require 'register_sources_psc/structs/address'
require 'register_sources_psc/structs/date_of_birth'
require 'register_sources_psc/structs/links'
require 'register_sources_psc/structs/name_elements'

module RegisterSourcesPsc
  class Individual < Dry::Struct
    attribute :address, Address.optional.default(nil)
    attribute :ceased_on, Types::Nominal::Date.optional.default(nil)
    attribute :country_of_residence, Types::String.optional.default(nil)
    attribute :date_of_birth, DateOfBirth.optional.default(nil)
    attribute :etag, Types::String.optional.default(nil)
    attribute :kind, IndividualKinds.optional.default(nil)
    attribute :links, Links.optional.default(nil)
    attribute :name, Types::String.optional.default(nil)
    attribute :name_elements, NameElements.optional.default(nil)
    attribute :nationality, Types::String.optional.default(nil)
    attribute :natures_of_control, Types.Array(Descriptions)
    attribute :notified_on, Types::Nominal::Date.optional.default(nil)
  end
end
