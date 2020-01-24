# frozen_string_literal: true

class StatusController < ApplicationController
  def index
    render plain: 'OK', status: :ok
  end
end
