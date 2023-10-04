# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  StatementKinds = Types::String.enum(
    'persons-with-significant-control-statement'
  )
end
