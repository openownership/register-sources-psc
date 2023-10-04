# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  PscStreamResourceKinds = Types::String.enum(
    'company-profile#company-profile',
    'filing-history#filing-history'
  )
end
