require 'register_sources_psc/types'

require 'register_sources_psc/enums/super_secure_descriptions'
require 'register_sources_psc/enums/super_secure_kinds'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class SuperSecure < Dry::Struct
    transform_keys(&:to_sym)

    attribute :ceased, Types::Nominal::Bool.optional.default(nil)
    attribute :description, SuperSecureDescriptions.optional.default(nil)
    attribute :etag, Types::String.optional.default(nil)
    attribute :kind, SuperSecureKinds.optional.default(nil)
    attribute :links, Links.optional.default(nil)
  end
end
