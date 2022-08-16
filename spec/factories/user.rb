FactoryBot.define do
  factory :user do
    name { 'User1' }
    email { 'user1@example.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
