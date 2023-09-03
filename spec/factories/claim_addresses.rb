FactoryBot.define do
  factory :claim_address do
    street_address {"1-2-3"}
    locality {"新宿区"}
    region {"東京"}
    postal_code {"222-9999"}
    country {"日本"}
  end
end
