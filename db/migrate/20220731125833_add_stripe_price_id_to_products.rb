# frozen_string_literal: true

class AddStripePriceIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :stripe_price_id, :string
  end
end
