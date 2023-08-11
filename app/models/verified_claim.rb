class VerifiedClaim < ApplicationRecord
  belongs_to :ekyc_user
  has_one :claim_address, dependent: :destroy
  accepts_nested_attributes_for :claim_address, update_only: true, allow_destroy: true
  has_one :verification_process, dependent: :destroy
  accepts_nested_attributes_for :verification_process, update_only: true, allow_destroy: true
end
