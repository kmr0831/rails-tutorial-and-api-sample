FactoryBot.define do
  factory :verification_evidence do
    time {DateTime.current}
    evidence_type {"document"}
    check_method {"vri"}
    document_type {"jp_individual_number_card"}
  end
end
