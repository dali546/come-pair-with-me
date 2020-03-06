# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_200_221_134_042) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'clients', force: :cascade do |t|
    t.string 'team_id'
    t.string 'team_name'
    t.string 'bot_user_id'
    t.string 'bot_access_token'
    t.string 'user_id'
    t.string 'user_access_token'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['team_id'], name: 'index_clients_on_team_id', unique: true
  end

  create_table 'leaderboard', force: :cascade do |t|
    t.date 'date'
    t.bigint 'winner_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'user_id'
    t.string 'user_name'
    t.string 'team_id'
    t.bigint 'total_points'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'leaderboard', 'users', column: 'winner_id'
  add_foreign_key 'users', 'clients', column: 'team_id', primary_key: 'team_id'
end
