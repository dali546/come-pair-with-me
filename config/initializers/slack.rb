# frozen_string_literal: true

require './lib/bot'

Slack::Events.configure do |config|
  config.signing_secret = ENV['SLACK_SIGNING_SECRET']
end

Client.find_each(&:send_start_up_message) if Client.table_exists?
