# frozen_string_literal: true

require "#{Rails.root}/lib/bot"

class Client < ApplicationRecord
  validates_presence_of :user_access_token
  validates_presence_of :bot_access_token
  validates_presence_of :bot_user_id
  validates_presence_of :team_id
  validates_presence_of :team_name
  has_many :users

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
