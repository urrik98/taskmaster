class AddOriginalListIdColumnToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :original_list, :integer
  end
end
