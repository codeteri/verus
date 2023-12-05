class AddAverageScoreToVotes < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :average_score, :float
  end
end
