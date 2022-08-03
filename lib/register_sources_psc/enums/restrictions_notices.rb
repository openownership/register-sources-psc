require 'register_sources_psc/types'

module RegisterSourcesPsc
  RestrictionsNotices = Types::String.enum(
    'restrictions-notice-withdrawn-by-court-order',
    'restrictions-notice-withdrawn-by-company'
  )
end
