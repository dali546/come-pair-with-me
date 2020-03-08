# frozen_string_literal: true

module Payloads
  module Interactivity
    class ViewSubmissionPayload < Payloads::InteractivityPayload
      attr_reader :view, :hash

      def initialize(params)
        @view = params[:view]
        @hash = params[:hash]
        super(params)
      end
    end
  end
end
