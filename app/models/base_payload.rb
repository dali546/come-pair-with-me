# frozen_string_literal: true

require 'json'

class BasePayload
  attr_reader :token, :team_id, :team_domain, :channel_id, :channel_name,
              :user_id, :user_name, :response_url, :trigger_id

  def initialize(params)
    @response_url = params[:response_url]
    @token = params[:token]
    @trigger_id = params[:trigger_id]
  end

  def self.from(params)
    new(params)
  end
end
