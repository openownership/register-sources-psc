# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  PscStreamResourceKinds = Types::String.enum(
    'company-profile#company-profile',
    'filing-history#filing-history'
  )
end
