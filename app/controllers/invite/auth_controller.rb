# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'faraday'
module Invite
  class AuthController < ApplicationController
    def index
      response = perform_oauth
      client = create_client(response)
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
      Client.create(
        team_id: response.fetch(:team).fetch(:id),
        team_name: response.fetch(:team).fetch(:name),
        bot_user_id: response.fetch(:bot_user_id),
        bot_access_token: response.fetch(:access_token),
        user_id: response.fetch(:authed_user).fetch(:id),
        user_access_token: response.fetch(:authed_user).fetch(:access_token)
      )
    end
  end
end
