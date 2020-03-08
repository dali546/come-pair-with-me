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
            blocks: update_response.to_json
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
        original_blocks + [
          BlockKit::Components::TextField[
            "Thank you for pairing! <@#{user.user_id}>"
          ]
        ]
      end

      def build_response
        [
          BlockKit::Components::Section[
            text: "<@#{user.user_id}> wants to pair!"
          ],
          BlockKit::Components::Divider[],
          BlockKit::Components::Section[
            text: "Reason for pairing: #{response_text}"
          ],
          BlockKit::Components::Divider[],
          BlockKit::Components::Actions[
            actions: [
              BlockKit::Components::Button[
                action_id: 'accept_pair_request',
                text: 'Accept', value: user.user_id
              ]
            ]
          ]
        ]
      end
    end
  end
end
