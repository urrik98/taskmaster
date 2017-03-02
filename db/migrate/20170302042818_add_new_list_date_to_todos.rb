class AddNewListDateToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :new_list_date, :date
  end
end
