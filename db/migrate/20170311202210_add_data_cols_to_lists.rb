class AddDataColsToLists < ActiveRecord::Migration[5.0]
  def change
    rename_column :lists, :completed, :completed_percentage
    add_column :lists, :completed_score, :decimal, :precision => 5, :score => 2
  end
end
