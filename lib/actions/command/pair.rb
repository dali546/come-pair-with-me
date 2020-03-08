# frozen_string_literal: true

module ComePairWithMe
  module Actions
    module Command
      module Pair
        def open_modal
          client.views_open(
            trigger_id: data.trigger_id,
            view: modal_response
          )
        end
        alias_method '/pair-with-me', :open_modal

        private

        def modal_response
          %(
            {
              "type": "modal",
              "private_metadata": "#{data.channel_id}",
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
                    "initial_value": "#{data.text}"
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
end
