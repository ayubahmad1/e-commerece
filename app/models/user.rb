# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image
  has_many :products, dependent: :destroy
  # has_many :comments, dependent: :destroy

  after_create :create_stripe_customer

  validate :validate_image
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  private

  def validate_image
    return unless image.attached?

    errors.add(:image, 'must be a png or gif') unless image.content_type.in?(%w[image/png image/gif
                                                                                image/jpg image/jpeg])
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
