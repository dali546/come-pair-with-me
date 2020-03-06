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

    attr_reader :client, :user
    private :client, :user

    def initialize(token)
      Slack.configure do |config|
        config.token = token
      end
      @client ||= Slack::Web::Client.new
    end

    def handle(command, data)
      @user = User.create_with(
        team_id: team_id(data),
        user_name: user_name(data)
      ).find_or_create_by!(user_id: user_id(data))
      send(command, data)
    rescue Slack::Web::Api::Errors::SlackError,
           Slack::Web::Api::Errors::TooManyRequestsError => e
      p e, e.response
      raise e
    rescue StandardError => e
      raise e
    end

    def user_name(payload)
      payload.user_name
    rescue => e
      payload.dig(:user, :username)
    end

    def team_id(payload)
      payload.team_id
    rescue => e
      payload.dig(:team, :id)
    end

    def user_id(payload)
       payload.user_id
    rescue => e
      payload.dig(:user, :id)
    end
  end
end
