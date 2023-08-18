class EkycUser < ApplicationRecord
  has_one :verified_claim, dependent: :destroy
end
