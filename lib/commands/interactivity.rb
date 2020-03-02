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
        @user.increment!(:total_points, 2)
        client.chat_postEphemeral(
          channel: payload.dig(:view, :private_metadata),
          attachments: %([{"pretext": "pre-hello", "text": "text-world"}]),
          text: "Congrats You gained 2 points. you now have #{@user.total_points}",
          user: @user.user_id
        )
      end

      def block_actions(payload)
        client.chat_update(
          channel: payload.dig(:channel, :id),
          ts: payload.dig(:message, :ts),
          text: 'Updated Message',
          blocks: update_response(payload)
        )
        @user.increment!(:total_points, 1)
        client.chat_postEphemeral(
          channel: payload.dig(:channel, :id),
          attachments: %([{"pretext": "pre-hello", "text": "text-world"}]),
          text: "Congrats You gained 1 point. you now have #{@user.total_points}",
          user: @user.user_id
        )
      end

      def update_response(payload)
        original_blocks = payload.dig(:message, :blocks)
        original_blocks.pop
        original_blocks.push(
          "type": 'section',
          "text": {
            "type": 'mrkdwn',
            "text": "Thank you for pairing! <@#{@user.user_id}>"
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
                "text": "<@#{@user.user_id}> wants to pair!"
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
