class AddKarmaScoreToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :karma_score, :integer
  end
end
