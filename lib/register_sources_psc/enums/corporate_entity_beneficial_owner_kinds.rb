# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  CorporateEntityBeneficialOwnerKinds = Types::String.enum(
    'corporate-entity-beneficial-owner'
  )
end
