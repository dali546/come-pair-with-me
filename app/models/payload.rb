# frozen_string_literal: true

require 'json'

class Payload
  attr_reader :token, :team_id, :team_domain, :channel_id, :channel_name,
              :user_id, :user_name, :command, :text, :response_url, :trigger_id

  def self.from(params)
    new(params)
  end
end
