class AddUserIndexToLists < ActiveRecord::Migration[5.0]
  def change
    add_reference :lists, :user, :index => true
    add_foreign_key :lists, :users
  end
end
