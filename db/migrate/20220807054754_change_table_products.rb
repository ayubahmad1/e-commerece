# frozen_string_literal: true

class ChangeTableProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :products, :user_id, false
    add_index :products, :name
  end
end
