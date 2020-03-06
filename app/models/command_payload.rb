# frozen_string_literal: true

class CommandPayload < Payload
  def initialize(params)
    @token = params[:token]
    @team_id = params[:team_id]
    @team_domain = params[:team_domain]
    @channel_id = params[:channel_id]
    @channel_name = params[:channel_name]
    @user_id = params[:user_id]
    @user_name = params[:user_name]
    @command = params[:command]
    @text = params[:text]
    @response_url = params[:response_url]
    @trigger_id = params[:trigger_id]
  end
end
