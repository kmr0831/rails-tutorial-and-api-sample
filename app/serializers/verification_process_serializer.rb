class VerificationProcessSerializer < ActiveModel::Serializer
  type 'verification_process'
  attributes :trust_framework, :time, :evidence

  def evidence
    evidences = []
    verification_evidence = object.verification_evidences.last
    evidence_attributes = {
      time: verification_evidence.time,
      evidence_type: verification_evidence.evidence_type,
      check_method: verification_evidence.check_method,
      document_type: verification_evidence.document_type,
    }
    evidences << evidence_attributes
  end
end
