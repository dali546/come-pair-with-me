# frozen_string_literal: true

module Event
  class PairController < ApplicationController
    def create
      Client.find_by_team_id(payload[:team_id]).handle_command(payload)
      head :ok
    end

    private

    def payload
      params.permit(
        :token, :command, :text, :response_url, :trigger_id, :user_id,
        :user_name, :team_id, :channel_id, :channel_name, :enterprise_id
      )
    end
  end
end
