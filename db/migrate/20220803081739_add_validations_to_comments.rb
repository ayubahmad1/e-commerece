# frozen_string_literal: true

class AddValidationsToComments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :comments, :body, false
  end
end
