class EkycUser < ApplicationRecord
  has_one :verified_claim
  accepts_nested_attributes_for :verified_claim, update_only: true
end
