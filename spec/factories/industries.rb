FactoryBot.define do
  factory :industry do
    name { Faker::Company.industry }
    created_at { Faker::Time.backward(days: 365) }
    updated_at { Faker::Time.backward(days: 1) }
  end
end
