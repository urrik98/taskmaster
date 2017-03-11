class AddDeleteColToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :delete, :boolean
  end
end
