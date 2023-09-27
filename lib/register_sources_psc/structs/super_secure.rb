# frozen_string_literal: true

require 'register_sources_psc/types'

require 'register_sources_psc/enums/super_secure_descriptions'
require 'register_sources_psc/enums/super_secure_kinds'
require 'register_sources_psc/structs/links'

module RegisterSourcesPsc
  class SuperSecure < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :ceased, Types::Params::Bool
    attribute? :description, SuperSecureDescriptions
    attribute :etag, Types::String
    attribute? :kind, SuperSecureKinds
    attribute? :links, Links
  end
end
