# frozen_string_literal: true

require_relative '../types'

module RegisterSourcesPsc
  # NOTE: only super-secure-persons-with-significant-control seems allowed?
  # rubocop:disable Layout/LineLength
  SuperSecureDescriptions = Types::String.enum(
    'super-secure-persons-with-significant-control', # "The person with significant control's details are not shown because restrictions on using or disclosing any of the individual’s particulars are in force under regulations under section 790ZG in relation to this company"
    'super-secure-beneficial-owner'                  # "The beneficial owners details are not shown because restrictions on using or disclosing any of the individual’s particulars are in force"
  )
  # rubocop:enable Layout/LineLength
end
