class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images
  scope :all_products_except_mine, lambda { |id| where.not(user_id: id)}
  # scope :all_products_except_mine, ->{ where.not(user_id: current_user.id) }
end
