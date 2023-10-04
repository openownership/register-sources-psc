# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  LegalPersonKinds = Types::String.enum(
    'legal-person-person-with-significant-control'
  )
end
