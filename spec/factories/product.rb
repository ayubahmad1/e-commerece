FactoryBot.define do
  factory :product do
    name { 'Product1 Name' }
    description { 'This is the description of the product 1' }
    quantity { 12345 }
    price { 12345 }
    user
  end
end
