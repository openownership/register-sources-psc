# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  PscStreamEventTypes = Types::String.enum(
    'changed',
    'deleted'
  )
end
