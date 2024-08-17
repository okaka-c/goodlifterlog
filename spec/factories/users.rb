FactoryBot.define do
  factory :user do
    name { "テストユーザー"}
    sequence(:email) { |n| "test#{n}@example.com" }
    password {'12345678'}
    password_confirmation {'12345678'}
    role {"user"}
    association :profile
  end
end