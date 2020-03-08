# frozen_string_literal: true

module Payloads
  module Interactivity
    class BlockActionPayload < Payloads::InteractivityPayload
      attr_reader :message, :actions

      def initialize(params)
        @message = params[:message]
        @actions = params[:actions]
        super(params)
      end
    end
  end
end
