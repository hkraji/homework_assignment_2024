FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    employee_count { Faker::Number.between(from: 1, to: 500) }

    current_deals_amount { 0 }
    association :industry

    created_at { Faker::Time.backward(days: 365) }
    updated_at { Faker::Time.backward(days: 1) }
  end
end
