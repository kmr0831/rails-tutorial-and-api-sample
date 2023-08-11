class VerifiedClaimSerializer < ActiveModel::Serializer
  type 'verified_claims'
  attributes :name, :given_name, :family_name, :birthdate, :address

  def address
    address_attributes = {
      street_address: object.claim_address.street_address,
      locality: object.claim_address.locality,
      region: object.claim_address.region,
      postal_code: object.claim_address.postal_code,
      country: object.claim_address.country
    }
    address_attributes
  end

  has_one :verification_process
end
