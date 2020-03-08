# frozen_string_literal: true

require 'slack-ruby-client'
require_relative 'actions/command'
require_relative 'actions/interactivity'
require_relative 'actions/event'
require_relative 'block_kit/components'

module ComePairWithMe
  class Bot
    include Actions::Command
    include Actions::Interactivity
    include Actions::Event

    attr_reader :client, :user, :data
    private :client, :user, :data

    def initialize(token)
      Slack.configure do |config|
        config.token = token
      end
      @client ||= Slack::Web::Client.new
    end

    def handle(command, data)
      @data = data
      @user = User.create_with(team_id: data.team_id, user_name: data.user_name)
                  .find_or_create_by!(user_id: data.user_id)
      send(command)
    rescue Slack::Web::Api::Errors::SlackError, Slack::Web::Api::Errors::TooManyRequestsError => e
      raise e
    rescue StandardError => e
      raise e
    end
  end
end
