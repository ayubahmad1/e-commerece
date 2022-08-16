FactoryBot.define do
  factory :comment do
    body { 'Comment1 Body' }
    user
    product
  end
end
