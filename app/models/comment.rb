# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :body, presence: true, length: { maximum: 20 }
end
