# frozen_string_literal: true

class ChangeUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :total_points, :bigint, default: 0
  end
end
