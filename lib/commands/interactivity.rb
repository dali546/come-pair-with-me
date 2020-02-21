# frozen_string_literal: true

module ComePairWithMe
  module Commands
    module Interactivity
      def view_submission(payload)
        client.chat_postMessage(
          channel: payload.dig(:view, :private_metadata),
          blocks: build_response(payload),
          text: 'pairing request successful'
        )
      end

      def block_actions(payload)
        client.chat_update(
          channel: payload.dig(:channel, :id),
          ts: payload.dig(:message, :ts),
          text: 'Updated Message',
          blocks: update_response(payload)
        )
      end

      def update_response(payload)
        original_blocks = payload.dig(:message, :blocks)
        original_blocks.pop
        original_blocks.push(
          "type": 'section',
          "text": {
            "type": 'mrkdwn',
            "text": "Thank you for pairing! <@#{user_id(payload)}>"
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
    end
  end
end
