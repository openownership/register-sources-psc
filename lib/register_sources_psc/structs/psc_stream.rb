require 'register_sources_psc/structs/company_record'
require 'register_sources_psc/structs/psc_stream_event'
require 'register_sources_psc/enums/psc_stream_resource_kinds'

module RegisterSourcesPsc
  class PscStream < Dry::Struct
    transform_keys(&:to_sym)

    attribute :data, RegisterSourcesPsc::CompanyRecordData
    attribute? :company_number, Types::String
    attribute :event, PscStreamEvent
    attribute :resource_id, Types::String
    attribute :resource_kind, Types::String # PscStreamResourceKinds
    attribute :resource_uri, Types::String
  end
end
