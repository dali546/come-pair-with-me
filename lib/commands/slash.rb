# frozen_string_literal: true

module ComePairWithMe
  module Commands
    module Slash
      def open_modal(payload)
        client.views_open(
          trigger_id: payload[:trigger_id],
          view: modal_response(payload)
        )
      end
      alias_method '/pair-with-me', :open_modal

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
end
