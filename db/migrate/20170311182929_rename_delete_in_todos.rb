class RenameDeleteInTodos < ActiveRecord::Migration[5.0]
  def change
    rename_column :todos, :delete, :vaporize
  end
end
