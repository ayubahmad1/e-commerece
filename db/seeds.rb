# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(name: 'user1', email: 'user11@gmail.com', password: '123456', password_confirmation: '123456')
user2 = User.create!(name: 'user2', email: 'user22@gmail.com', password: '123456', password_confirmation: '123456')

product1 = user1.products.create!(
  name: 'Product 1',
  description: 'This is a test product 1',
  quantity: 10,
  price: 40_321
)
product1.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default1.jpeg')),
  filename: 'default1.jpeg',
  content_type: 'image/jpeg'
)

product2 = user1.products.create!(
  name: 'Product 2',
  description: 'This is a test product 2',
  quantity: 10,
  price: 21_321
)
product2.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default2.jpeg')),
  filename: 'default2.jpeg',
  content_type: 'image/jpeg'
)

product3 = user1.products.create!(name: 'Product 3',
                                  description: 'This is a test produst 3',
                                  quantity: 10,
                                  price: 40_321)
product3.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default3.jpeg')),
  filename: 'default3.jpeg',
  content_type: 'image/jpeg'
)

product4 = user2.products.create!(
  name: 'Product 4',
  description: 'This is a test product 4',
  quantity: 10,
  price: 40_321
)

product4.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default4.jpeg')),
  filename: 'default4.jpeg',
  content_type: 'image/jpeg'
)

product5 = user2.products.create!(
  name: 'Product 5',
  description: 'This is a test product 5',
  quantity: 10,
  price: 40_321
)
product5.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default5.jpeg')),
  filename: 'default5.jpeg',
  content_type: 'image/jpeg'
)

product6 = user2.products.create!(name: 'Product 6',
                                  description: 'This is a test produst 3',
                                  quantity: 10,
                                  price: 40_321)
product6.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default6.jpeg')),
  filename: 'default6.jpeg',
  content_type: 'image/jpeg'
)
