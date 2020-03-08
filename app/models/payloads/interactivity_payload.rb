# frozen_string_literal: true

require 'json'

module Payloads
  class InteractivityPayload < BasePayload
    attr_reader :container_type, :container_message_ts, :container_channel_id,
                :container_is_ephemeral, :type

    def initialize(params)
      @type = params[:type]
      @team_id = params.dig(:team, :id)
      @team_domain = params.dig(:team, :domain)
      @user_id = params.dig(:user, :id)
      @user_name = params.dig(:user, :username)
      @channel_id = params.dig(:channel, :id)
      @channel_name = params.dig(:channel, :name)
      super(params)
    end

    class << self
      def from(params)
        case parsed_params(params[:payload]).fetch(:type)
        when 'block_actions'
          Interactivity::BlockActionPayload.new(parsed_params(params[:payload]))
        when 'view_submission'
          Interactivity::ViewSubmissionPayload.new(parsed_params(params[:payload]))
        else
          p parsed_params(params[:payload])
          raise StandardError, 'Unknown Interactivity Payload'
        end
      end

      def parsed_params(params)
        JSON.parse(params, symbolize_names: true)
      end
    end
  end
end
