# frozen_string_literal: true

class CommandController < ApplicationController
  private

  def client
    Client.find_by_team_id(payload.team_id)
  end

  def payload
    CommandPayload.from(slash_params)
  end

  def slash_params
    params.permit(
      :token, :team_id, :team_domain, :channel_id, :channel_name, :user_id,
      :user_name, :command, :text, :response_url, :trigger_id
    )
  end
end
