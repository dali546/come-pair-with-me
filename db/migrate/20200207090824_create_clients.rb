# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :team_id
      t.string :team_name
      t.string :bot_user_id
      t.string :bot_access_token
      t.string :user_id
      t.string :user_access_token
      t.timestamps
    end
  end
end
