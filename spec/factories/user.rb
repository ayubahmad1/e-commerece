FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    name { 'User1' }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { '123456' }
    password_confirmation { '123456' }
    confirmed_at { Time.zone.now }
  end
end
