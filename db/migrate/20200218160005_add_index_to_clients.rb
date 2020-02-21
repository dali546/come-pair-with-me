class AddIndexToClients < ActiveRecord::Migration[6.0]
  def change
    add_index :clients, :team_id, :unique => true
  end
end
