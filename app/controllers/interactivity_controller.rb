# frozen_string_literal: true

require 'json'

class InteractivityController < ApplicationController
  def create
    client.handle_interactivity(payload)
    head :ok
  end

  private

  def payload
    Payloads::InteractivityPayload.from(interactivity_params)
  end

  def interactivity_params
    params.permit(:payload)
  end
end
