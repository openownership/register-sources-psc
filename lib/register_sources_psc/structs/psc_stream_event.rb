# frozen_string_literal: true

require 'register_sources_psc/types'
require 'register_sources_psc/enums/psc_stream_event_types'

module RegisterSourcesPsc
  class PscStreamEvent < Dry::Struct
    transform_keys(&:to_sym)

    attribute :fields_changed, Types.Array(Types::String).optional.default(nil)
    attribute :published_at, Types::Nominal::DateTime
    attribute :timepoint, Types::Nominal::Integer
    attribute :type, PscStreamEventTypes
  end
end
