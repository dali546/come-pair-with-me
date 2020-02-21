# frozen_string_literal: true

require 'slack-ruby-client'
require_relative 'commands/slash'
require_relative 'commands/interactivity'
require_relative 'commands/event'

module ComePairWithMe
  class Bot
    include Commands::Interactivity
    include Commands::Slash
    include Commands::Event

    attr_reader :client
    private :client

    def initialize(token)
      Slack.configure do |config|
        config.token = token
      end
      @client ||= Slack::Web::Client.new
    end

    def handle(command, data)
      send(command, data)
    rescue Slack::Web::Api::Errors::SlackError,
           Slack::Web::Api::Errors::TooManyRequestsError => e
      p e, e.response
      raise e
    rescue StandardError => e
      raise e
    end

    def user_id(payload)
      payload.dig(:user, :id)
    end

    def response_text(payload)
      payload.dig(:view, :state, :values, :pairing_message, :field_one, :value)
    end
  end
end
