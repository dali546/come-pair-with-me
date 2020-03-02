# frozen_string_literal: true

require_relative 'slash/leaderboard'
require_relative 'slash/pair'
module ComePairWithMe
  module Commands
    module Slash
      include Slash::Pair
      include Slash::Leaderboard
    end
  end
end
