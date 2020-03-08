# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def client
    Client.find_by_team_id(payload.team_id)
  end
end
