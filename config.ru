# frozen_string_literal: true

require 'dotenv'
Dotenv.load

require_relative 'config/environment'

run Rails.application
