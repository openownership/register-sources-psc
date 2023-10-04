# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  RestrictionsNotices = Types::String.enum(
    'restrictions-notice-withdrawn-by-court-order',
    'restrictions-notice-withdrawn-by-company'
  )
end
