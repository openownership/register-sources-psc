# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  CorporateEntityKinds = Types::String.enum(
    'corporate-entity-person-with-significant-control'
  )
end
