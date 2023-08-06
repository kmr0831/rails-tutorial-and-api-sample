class VerificationProcess < ApplicationRecord
  belongs_to :verified_claim
  has_many :verification_evidences
  accepts_nested_attributes_for :verification_evidences

  validates :trust_framework, presence: true
end
