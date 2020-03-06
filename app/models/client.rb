# frozen_string_literal: true

require "#{Rails.root}/lib/bot"

class Client < ApplicationRecord
  has_many :users, foreign_key: :team_id, primary_key: :team_id

  def bot
    @bot ||= ComePairWithMe::Bot.new(bot_access_token)
  end

  def handle(action, payload)
    bot.handle(action, payload)
  end

  def handle_event(payload)
    handle(payload.fetch(:type), payload)
  end

  def handle_command(payload)
    handle(payload.command, payload)
  end
end
