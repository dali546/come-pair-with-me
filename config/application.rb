# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'slack-ruby-client'

Bundler.require(*Rails.groups)

module ComePairWithMe
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true
    config.active_support.escape_html_entities_in_json = false
  end
end
