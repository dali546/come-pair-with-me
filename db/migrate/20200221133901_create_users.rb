class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :user_name
      t.string :team_id
      t.bigint :total_points
      t.timestamps
    end
    add_foreign_key :users, :clients, column: :team_id, primary_key: :team_id
  end
end
