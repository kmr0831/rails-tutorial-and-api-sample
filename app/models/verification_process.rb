class VerificationProcess < ApplicationRecord
  belongs_to :verified_claim
  has_many :verification_evidences, dependent: :destroy
  accepts_nested_attributes_for :verification_evidences, allow_destroy: true

  TRUST_FRAMEWORK = ['ssa']

  validates :trust_framework, presence: true, inclusion: { in: TRUST_FRAMEWORK }
end
