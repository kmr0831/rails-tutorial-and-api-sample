class EkycUser < ApplicationRecord
  has_one :verified_claim, dependent: :destroy
  # accepts_nested_attributes_for :verified_claim, update_only: true, allow_destroy: true
  # accepts_nested_attributes_for :verified_claim
end
