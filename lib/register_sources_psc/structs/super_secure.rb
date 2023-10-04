# frozen_string_literal: true

require_relative '../enums/super_secure_descriptions'
require_relative '../enums/super_secure_kinds'
require_relative '../types'
require_relative 'links'

module RegisterSourcesPsc
  class SuperSecure < Dry::Struct
    transform_keys(&:to_sym)

    attribute? :ceased,      Types::Params::Bool
    attribute? :description, SuperSecureDescriptions
    attribute  :etag,        Types::String
    attribute? :kind,        SuperSecureKinds
    attribute? :links,       Links
  end
end
