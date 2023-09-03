FactoryBot.define do
  factory :verified_claim do
    name {'テスト 太郎'}
    given_name {'太郎'}
    family_name {'テスト'}
    birthdate {'2020-01-24'}

    trait :with_claim_address do
      after(:build) do |verified_claim|
        build(:claim_address, verified_claim: verified_claim)
      end
    end

    trait :with_verification_process do
      after(:build) do |verified_claim|
        verification_process = build(:verification_process, verified_claim: verified_claim)
        verification_process.verification_evidences << build(:verification_evidence, verification_process: verification_process)
      end
    end
  end
end
