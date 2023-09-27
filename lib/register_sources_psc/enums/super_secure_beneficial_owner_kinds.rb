# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  SuperSecureBeneficialOwnerKinds = Types::String.enum(
    'super-secure-beneficial-owner'
  )
end
