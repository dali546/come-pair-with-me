# frozen_string_literal: true

module Payloads
  class CommandPayload < BasePayload
    attr_reader :command, :text

    def initialize(params)
      @team_id = params[:team_id]
      @team_domain = params[:team_domain]
      @channel_id = params[:channel_id]
      @channel_name = params[:channel_name]
      @user_id = params[:user_id]
      @user_name = params[:user_name]
      @command = params[:command]
      @text = params[:text]
      super(params)
    end
  end
end
