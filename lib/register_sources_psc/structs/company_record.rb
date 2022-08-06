require 'register_sources_psc/types'

require 'register_sources_psc/structs/corporate_entity'
require 'register_sources_psc/structs/individual'
require 'register_sources_psc/structs/legal_person'
require 'register_sources_psc/structs/statement'
require 'register_sources_psc/structs/super_secure'

module RegisterSourcesPsc
  UnknownRecordKindError = Class.new(StandardError)

  CompanyRecordData = Types::Nominal::Any.constructor do |value|
    next value unless value.is_a? Hash

    case (value['kind'] || value[:kind])
    when CorporateEntityKinds['corporate-entity-person-with-significant-control']
      CorporateEntity.new(**value)
    when IndividualKinds['individual-person-with-significant-control']
      Individual.new(**value)
    when LegalPersonKinds['legal-person-person-with-significant-control']
      LegalPerson.new(**value)
    when StatementKinds['persons-with-significant-control-statement']
      Statement.new(**value)
    when SuperSecureKinds['super-secure-person-with-significant-control']
      SuperSecure.new(**value)
    else
      raise UnknownRecordKindError
    end
  end

  class CompanyRecord < Dry::Struct
    transform_keys(&:to_sym)

    attribute :company_number, Types::String.optional.default(nil)
    attribute :data, CompanyRecordData
  end
end
