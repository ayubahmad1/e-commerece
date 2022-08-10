# frozen_string_literal: true

class ChangeTableComments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :comments, :user_id, false
    change_column_null :comments, :product_id, false
  end
end
