class VerificationEvidence < ApplicationRecord
  belongs_to :verification_process

  CHECK_METHOD = ['vri', 'vcrypt']
  DOCUMENT_TYPE = ['jp_individual_number_card']

  validates :check_method, inclusion: { in: CHECK_METHOD }
  validates :document_type, inclusion: { in: DOCUMENT_TYPE }
end
