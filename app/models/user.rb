# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :client, foreign_key: :team_id, primary_key: :team_id
end
