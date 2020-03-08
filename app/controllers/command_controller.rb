# frozen_string_literal: true

class CommandController < ApplicationController
  private

  def payload
    Payloads::CommandPayload.from(slash_params)
  end

  def slash_params
    params.permit(
      :token, :team_id, :team_domain, :channel_id, :channel_name, :user_id,
      :user_name, :command, :text, :response_url, :trigger_id
    )
  end
end
