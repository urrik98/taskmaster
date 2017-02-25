class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.text :desc
      t.string :status
      t.references :list, foreign_key: true

      t.timestamps
    end
  end
end
