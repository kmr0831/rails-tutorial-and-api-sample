class VerifiedClaim < ApplicationRecord
  belongs_to :ekyc_user
  has_one :claim_address, dependent: :destroy
  has_one :verification_process, dependent: :destroy
end
