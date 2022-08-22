FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    name { Faker::Internet.name }
    # sequence(:email) { |n| "user-#{n}@example.com" }
    email {Faker:: Internet.email}
    password { '123456' }
    password_confirmation { '123456' }
    confirmed_at { Time.zone.now }
  end
end
