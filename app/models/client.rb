# frozen_string_literal: true

class Client < ApplicationRecord
  validates_presence_of :user_access_token
  validates_presence_of :bot_access_token
  validates_presence_of :bot_user_id

  def bot
    @bot ||= ComePairWithMe::Bot.new(bot_access_token)
  end

  def send_start_up_message
    bot.start_up_message
  end

  def handle(payload)
    if payload.fetch(:type) == 'block_actions'
      bot.handle_button(payload)
    else
      bot.handle_submission(payload)
    end
  end

  def open_modal(payload)
    bot.open_modal(payload)
  end
end
