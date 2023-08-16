require 'register_sources_psc/types'

require 'register_sources_psc/enums/super_secure_descriptions'
require 'register_sources_psc/enums/super_secure_beneficial_owner_kinds'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class SuperSecureBeneficialOwner < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :ceased, Types::Params::Bool
    attribute? :description, SuperSecureDescriptions
    attribute :etag, Types::String
    attribute? :is_sanctioned, Types::Params::Bool
    attribute? :kind, SuperSecureBeneficialOwnerKinds
    attribute? :links, Links
  end
end
