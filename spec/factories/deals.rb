FactoryBot.define do
  factory :deal do
    name { "Deal #{Faker::Number.unique.number(digits: 5)}" }
    amount { Faker::Number.between(from: 100, to: 5000) }
    status { %w[pending, won, lost].sample }
    association :company

    created_at { Faker::Time.backward(days: 365) }
    updated_at { Faker::Time.backward(days: 1) }
  end
end
