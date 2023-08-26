class VerifiedClaimSerializer < ActiveModel::Serializer
  # type 'verified_claims'
  attributes :name, :given_name, :family_name, :birthdate

  attribute :address do
    { 
      street_address: address.street_address, 
      locality: address.locality, 
      region: address.region, 
      postal_code: address.postal_code, 
      country: address.country 
    }
  end
  
  attribute :process do
    {
      trust_framework: process.trust_framework,
      time: process.time,
      evidences: evidences.map do |evi|
        {
          time: evi.time,
          evidence_type: evi.evidence_type,
          check_method: evi.check_method,
          document_type: evi.document_type
        }
      end
    }
  end

  def address
    object.claim_address
  end

  def process
    object.verification_process
  end

  def evidences
    object.verification_process.verification_evidences
  end
  
  # def address
  #   address_attributes = {
  #     street_address: object.claim_address.street_address,
  #     locality: object.claim_address.locality,
  #     region: object.claim_address.region,
  #     postal_code: object.claim_address.postal_code,
  #     country: object.claim_address.country
  #   }
  #   address_attributes
  # end

  # has_one :verification_process
end
