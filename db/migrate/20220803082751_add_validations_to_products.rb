class AddValidationsToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :products, :name, false
    change_column_null :products, :description, false
    change_column_null :products, :quantity, false
    change_column_null :products, :price, false
  end
end
