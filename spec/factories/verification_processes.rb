FactoryBot.define do
  factory :verification_process do
    trust_framework {"ssa"}
    time {DateTime.current}

    trait :with_verification_evidence do
      after(:build) do |verification_process|
        verification_process.verification_evidences << build(:verification_evidence, verification_process: verification_process)
      end
    end
  end
end
