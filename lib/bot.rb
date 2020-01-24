# frozen_string_literal: true

require 'slack-ruby-client'
module ComePairWithMe
  class Bot
    attr_reader :client
    private :client

    def initialize(token)
      Slack.configure do |config|
        config.token = token
      end
      @client ||= Slack::Web::Client.new
    end

    def handle_submission(payload)
      client.chat_postMessage(
        channel: payload.dig(:view, :private_metadata),
        blocks: build_response(payload),
        text: 'pairing request successful'
      )
    end

    def handle_button(payload)
      p payload
      p payload[:channel], payload.dig(:channel, :name), "MR FANCYYYYYYYYYYY"
      client.chat_update(
        channel: payload.dig(:channel, :id),
        ts: payload.dig(:message, :ts),
        text: 'Updated Message',
        blocks: update_response(payload)
      )
    rescue StandardError => e
      p e.message, e.response
      raise e
    end

    def update_response(payload)
      original_blocks = payload.dig(:message, :blocks)
      original_blocks.pop
      original_blocks.push(
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "Thank you for pairing! <@#{user_id(payload)}>",
            }
          }
        )
        original_blocks
    end

    def build_response(payload)
      %(
        [
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "<@#{user_id(payload)}> wants to pair!"
            }
          },
          {
            "type": "divider"
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "Reason for pairing: #{response_text(payload)}"
            }
          },
          {
            "type": "divider"
          },
          {
            "type": "actions",
            "elements": [
              {
                "type": "button",
                "text": {
                  "type": "plain_text",
                  "text": "Accept",
                  "emoji": true
                },
                "value": "click_me_123"
              }
            ]
          }
        ]
      )
    end

    def user_id(payload)
      payload.dig(:user, :id)
    end

    def response_text(payload)
      payload.dig(:view, :state, :values, :pairing_message, :field_one, :value)
    end

    def open_modal(payload)
      client.views_open(
        trigger_id: payload[:trigger_id],
        view: modal_response(payload)
      )
    rescue StandardError => e
      p e.message, e.response
      raise e
    end

    def start_up_message
      # client.chat_postMessage(channel: 'general', text: "Hi,It's Alive")
    rescue StandardError => e
      p e
      raise e
    end

    def modal_response(payload)
      %(
        {
          "type": "modal",
          "private_metadata": "#{payload[:channel_id]}",
          "title": {
              "type": "plain_text",
              "text": "New Pairing Request",
              "emoji": true
          },
          "submit": {
              "type": "plain_text",
              "text": "Submit",
              "emoji": true
          },
          "close": {
              "type": "plain_text",
              "text": "Cancel",
              "emoji": true
          },
          "blocks": [
            {
              "type": "section",
              "text": {
                "type": "mrkdwn",
                "text": "Write a brief description of who what where and why you want to pair"
              }
            },
            {
              "type": "divider"
            },
            {
              "type": "input",
              "element": {
                "type": "plain_text_input",
                "multiline": true,
                "action_id": "field_one",
                "initial_value": "#{payload[:text]}"
              },
              "label": {
                "type": "plain_text",
                "text": "Pairing Description",
                "emoji": true
              },
              "block_id": "pairing_message"
            }
          ]
        }
      )
    end
  end
end
