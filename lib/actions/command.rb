# frozen_string_literal: true

require_relative 'command/leaderboard'
require_relative 'command/pair'
module ComePairWithMe
  module Actions
    module Command
      include Command::Pair
      include Command::Leaderboard
    end
  end
end
