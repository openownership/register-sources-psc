require 'register_sources_psc/types'

require 'register_sources_psc/enums/super_secure_descriptions'
require 'register_sources_psc/enums/super_secure_kinds'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class SuperSecure < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :ceased, Types::Nominal::Bool.optional
    attribute? :description, SuperSecureDescriptions.optional
    attribute :etag, Types::String
    attribute? :kind, SuperSecureKinds.optional
    attribute? :links, Links.optional
  end
end
