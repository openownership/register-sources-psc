# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  LegalPersonBeneficialOwnerKinds = Types::String.enum(
    'legal-person-beneficial-owner'
  )
end
