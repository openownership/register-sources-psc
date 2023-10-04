# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  # NOTE: only super-secure-person-with-significant-control seems allowed?
  SuperSecureKinds = Types::String.enum(
    'super-secure-person-with-significant-control'
  )
end
