class CorrectCompletedScoreInListModel < ActiveRecord::Migration[5.0]
  def change
    change_column :lists, :completed_score, :decimal, :precision => 5, :scale => 2
  end
end
