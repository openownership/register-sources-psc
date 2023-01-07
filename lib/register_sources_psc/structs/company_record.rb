require 'register_sources_psc/types'

require 'register_sources_psc/structs/corporate_entity'
require 'register_sources_psc/structs/individual'
require 'register_sources_psc/structs/legal_person'
require 'register_sources_psc/structs/statement'
require 'register_sources_psc/structs/super_secure'

require 'register_sources_psc/structs/corporate_entity_beneficial_owner'
require 'register_sources_psc/structs/individual_beneficial_owner'
require 'register_sources_psc/structs/legal_person_beneficial_owner'
require 'register_sources_psc/structs/super_secure_beneficial_owner'

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
    when CorporateEntityBeneficialOwnerKinds['corporate-entity-beneficial-owner']
      CorporateEntityBeneficialOwner.new(**value)
    when IndividualBeneficialOwnerKinds['individual-beneficial-owner']
      IndividualBeneficialOwner.new(**value)
    when LegalPersonBeneficialOwnerKinds['legal-person-beneficial-owner']
      LegalPersonBeneficialOwner.new(**value)
    when SuperSecureBeneficialOwnerKinds['super-secure-beneficial-owner']
      SuperSecureBeneficialOwner.new(**value)
    else
      raise UnknownRecordKindError
    end
  end

  class CompanyRecord < Dry::Struct
    transform_keys(&:to_sym)

    attribute :company_number, Types::String.optional.default(nil)
    attribute :data, CompanyRecordData

    def roe?
      [
        CorporateEntityBeneficialOwnerKinds['corporate-entity-beneficial-owner'],
        IndividualBeneficialOwnerKinds['individual-beneficial-owner'],
        LegalPersonBeneficialOwnerKinds['legal-person-beneficial-owner'],
        SuperSecureBeneficialOwnerKinds['super-secure-beneficial-owner']
      ].include? data.kind
    end
  end
end
