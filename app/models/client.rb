# frozen_string_literal: true

require "#{Rails.root}/lib/bot"

class Client < ApplicationRecord
  has_many :users, foreign_key: :team_id, primary_key: :team_id

  def bot
    @bot ||= ComePairWithMe::Bot.new(bot_access_token)
  end

  def handle(payload)
    bot.handle(payload.fetch(:type), payload)
  end

  def handle_command(payload)
    bot.handle(payload.fetch(:command), payload)
  end
end
