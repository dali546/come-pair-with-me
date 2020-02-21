# frozen_string_literal: true

Slack::Events.configure do |config|
  config.signing_secret = ENV['SLACK_SIGNING_SECRET']
end
