# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  IndividualBeneficialOwnerKinds = Types::String.enum(
    'individual-beneficial-owner'
  )
end
