# frozen_string_literal: true

module Commands
  class LeaderboardController < CommandController
    def create
      client.handle_command(payload)
      head :ok
    end
  end
end
