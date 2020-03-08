# frozen_string_literal: true

module ComePairWithMe
  module Actions
    module Interactivity
      def view_submission
        client.chat_postMessage(
          channel: data.view.fetch(:private_metadata),
          blocks: build_response, text: 'Pairing Request Successful.'
        )
        increase_score(by: 2)
      end

      def increase_score(by: 1)
        user.increment!(:total_points, by)
        client.chat_postEphemeral(
          channel: data.view.fetch(:private_metadata),
          text: "Congrats You gained 2 points. you now have #{user.total_points} points",
          user: data.user_id
        )
      end

      # currently only means accept button.
      def block_actions
        if user.user_id == data.actions.dig(0, :value)
          client.chat_postEphemeral(
            channel: data.channel_id,
            text: "You Can't click your own button",
            user: user.user_id
          )
        else
          client.chat_update(
            channel: data.channel_id,
            ts: data.message.fetch(:ts),
            blocks: update_response
          )
          increase_score
        end
      end

      def response_text
        data.view.dig(:state, :values, :pairing_message, :field_one, :value)
      end

      def update_response
        original_blocks = data.message.fetch(:blocks)
        original_blocks.pop
        original_blocks.push(
          "type": 'section',
          "text": {
            "type": 'mrkdwn',
            "text": "Thank you for pairing! <@#{user.user_id}>"
          }
        )
        original_blocks
      end

      def build_response
        %(
          [
            {
              "type": "section",
              "text": {
                "type": "mrkdwn",
                "text": "<@#{user.user_id}> wants to pair!"
              }
            },
            {
              "type": "divider"
            },
            {
              "type": "section",
              "text": {
                "type": "mrkdwn",
                "text": "Reason for pairing: #{response_text}"
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
                  "action_id": "accept_pair_request",
                  "text": {
                    "type": "plain_text",
                    "text": "Accept",
                    "emoji": true
                  },
                  "value": "#{user.user_id}"
                }
              ]
            }
          ]
        )
      end
    end
  end
end
