FactoryBot.define do
  factory :comment do
    sequence(:id) { |n| n }
    body { 'Comment1 Body' }
    user
    product
  end
end
