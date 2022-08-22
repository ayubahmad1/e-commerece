FactoryBot.define do
  factory :comment do
    sequence(:id) { |n| n }
    body { Faker::Lorem.sentence(word_count: 1)}
    user
    product
  end
end
