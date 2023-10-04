# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  PscStreamEventTypes = Types::String.enum(
    'changed',
    'deleted'
  )
end
