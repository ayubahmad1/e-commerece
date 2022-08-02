# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy

  after_create :create_stripe_customer
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def create_stripe_customer
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
