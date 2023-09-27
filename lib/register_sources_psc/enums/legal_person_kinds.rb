# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  LegalPersonKinds = Types::String.enum(
    'legal-person-person-with-significant-control'
  )
end
