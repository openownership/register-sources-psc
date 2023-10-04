# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  IndividualBeneficialOwnerKinds = Types::String.enum(
    'individual-beneficial-owner'
  )
end
