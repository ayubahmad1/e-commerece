class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :name, presence: true, length: { in: 6..20, too_long: '20 characters is the maximum allowed' }
  validates :description, presence: true, length: { minimum: 20 }
  validates :quantity, numericality: { only_integer: true }
  validates :price, numericality: {greater_than: 0, less_than: 1_000_000 }

  scope :all_products_except_mine, lambda { |id| where.not(user_id: id) }

  def to_s
    name
  end

  def to_builder(qty = 2)
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity qty
    end
  end

  after_create do
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product, unit_amount: self.price, currency: "usd")
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end
end
