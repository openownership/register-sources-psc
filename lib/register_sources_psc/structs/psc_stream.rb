# frozen_string_literal: true

require_relative '../enums/psc_stream_resource_kinds'
require_relative '../types'
require_relative 'company_record'
require_relative 'psc_stream_event'

module RegisterSourcesPsc
  class PscStream < Dry::Struct
    transform_keys(&:to_sym)

    attribute  :data,           RegisterSourcesPsc::CompanyRecordData
    attribute? :company_number, Types::String
    attribute  :event,          PscStreamEvent
    attribute  :resource_id,    Types::String
    attribute  :resource_kind,  Types::String                         # PscStreamResourceKinds
    attribute  :resource_uri,   Types::String
  end
end
