# frozen_string_literal: true

class AddStripeProductIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :stripe_product_id, :string
  end
end
