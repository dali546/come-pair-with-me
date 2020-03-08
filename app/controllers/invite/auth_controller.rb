# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'faraday'

module Invite
  class AuthController < ApplicationController
    def index
      response = perform_oauth
      create_client(response)
      p response
      render json: response
    end

    private

    def auth_code
      params.require(:code)
    end

    def perform_oauth
      Slack::Web::Client.new.oauth_v2_access(
        code: auth_code,
        client_id: ENV['SLACK_CLIENT_ID'],
        client_secret: ENV['SLACK_CLIENT_SECRET']
      )
    end

    def create_client(response)
      Client.create_with(
        team_name: response.dig(:team, :name),
        bot_user_id: response.fetch(:bot_user_id),
        bot_access_token: response.fetch(:access_token),
        user_id: response.dig(:authed_user, :id),
        user_access_token: response.dig(:authed_user, :access_token)
      ).find_or_create_by(team_id: response.dig(:team, :id))
    end
  end
end
