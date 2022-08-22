FactoryBot.define do
  factory :product do
    sequence(:id) { |n| n }
    name { Faker::Internet.name }
    description { Faker::Lorem.sentence(word_count: 10) }
    quantity { 12345 }
    price { 12345 }
    user
  end
end
