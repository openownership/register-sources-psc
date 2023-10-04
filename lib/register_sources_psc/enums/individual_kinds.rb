# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  IndividualKinds = Types::String.enum(
    'individual-person-with-significant-control'
  )
end
