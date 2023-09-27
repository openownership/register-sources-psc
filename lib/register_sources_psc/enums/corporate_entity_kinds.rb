# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  CorporateEntityKinds = Types::String.enum(
    'corporate-entity-person-with-significant-control'
  )
end
