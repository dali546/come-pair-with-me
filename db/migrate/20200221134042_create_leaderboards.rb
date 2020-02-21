class CreateLeaderboards < ActiveRecord::Migration[6.0]
  def change
    create_table :leaderboard do |t|
      t.date :date
      t.bigint :winner_id
      t.timestamps
    end
    add_foreign_key :leaderboard, :users, column: :winner_id
  end
end
