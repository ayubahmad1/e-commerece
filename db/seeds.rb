# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(username: 'user1', email: 'user1@gmail.com', password: '123456', password_confirmation: '123456',
             confirmed_at: Time.zone.now)
user2 = User.create!(username: 'user2', email: 'user2@gmail.com', password: '123456', password_confirmation: '123456',
             confirmed_at: Time.zone.now)

product1 = user1.products.create!(
  title: 'Product 1',
  description: 'This is a test produst 1',
  price: 23
)
product1.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default1.jpg')),
  filename: 'default1.jpg',
  content_type: 'image/jpg'
)

product2 = user1.products.create!(
  title: 'Product 2',
  description: 'This is a test product 2',
  price: 21
)
product2.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default2.jpg')),
  filename: 'default2.jpg',
  content_type: 'image/jpg'
)

product3 = user1.products.create!(title: 'Product 3',
                                  description: 'This is a test produst 3',
                                  price: 334)
product3.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default3.jpg')),
  filename: 'default3.jpg',
  content_type: 'image/jpg'
)

product4 = user2.products.create!(
  title: 'Product 1',
  description: 'This is a test produst 1',
  price: 23
)

product4.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default1.jpg')),
  filename: 'default1.jpg',
  content_type: 'image/jpg'
)

product5 = user2.products.create!(
  title: 'Product 2',
  description: 'This is a test product 2',
  price: 21
)
product5.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default2.jpg')),
  filename: 'default2.jpg',
  content_type: 'image/jpg'
)

product6 = user2.products.create!(title: 'Product 3',
                                  description: 'This is a test produst 3',
                                  price: 334)
product6.images.attach(
  io: File.open(Rails.root.join('app/assets/images/default3.jpg')),
  filename: 'default3.jpg',
  content_type: 'image/jpg'
)
