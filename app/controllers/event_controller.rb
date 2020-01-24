# frozen_string_literal: true

require 'json'

class EventController < ApplicationController
  def create
    Client.find_by_team_id(team_id).handle(payload_hash)
    head :ok
  end

  private

  def payload
    params[:payload]
  end

  def payload_hash
    JSON.parse(payload).with_indifferent_access
  end

  def team_id
    payload_hash.dig(:team, :id)
  end
end
