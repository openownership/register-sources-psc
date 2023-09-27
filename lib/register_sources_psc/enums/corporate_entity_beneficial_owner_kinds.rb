# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  CorporateEntityBeneficialOwnerKinds = Types::String.enum(
    'corporate-entity-beneficial-owner'
  )
end
