class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :body, presence: true, length: { in: 6..20 }
end
