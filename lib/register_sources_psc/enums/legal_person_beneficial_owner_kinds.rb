# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  LegalPersonBeneficialOwnerKinds = Types::String.enum(
    'legal-person-beneficial-owner'
  )
end
