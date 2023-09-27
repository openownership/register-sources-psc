# frozen_string_literal: true

require 'register_sources_psc/types'

module RegisterSourcesPsc
  StatementKinds = Types::String.enum(
    'persons-with-significant-control-statement'
  )
end
