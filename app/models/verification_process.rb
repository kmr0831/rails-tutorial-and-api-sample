class VerificationProcess < ApplicationRecord
  belongs_to :verified_claim
  has_many :verification_evidences, dependent: :destroy

  TRUST_FRAMEWORK = ['ssa']

  validates :trust_framework, presence: true, inclusion: { in: TRUST_FRAMEWORK }
end
