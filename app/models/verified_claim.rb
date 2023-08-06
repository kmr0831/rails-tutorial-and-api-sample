class VerifiedClaim < ApplicationRecord
  belongs_to :ekyc_user
  has_one :claim_address
  accepts_nested_attributes_for :claim_address, update_only: true
  has_one :verification_process
  accepts_nested_attributes_for :verification_process, update_only: true
end
