# frozen_string_literal: true

module ComePairWithMe
  module Actions
    module Command
      module Leaderboard
        def show_leaderboard
          client.chat_postEphemeral(
            channel: data.channel_id,
            attachments: %([{"pretext": "pre-hello", "text": "text-world"}]),
            text: 'Pair Leaderboard',
            blocks: leaderboard_response,
            user: data.user_id
          )
        end
        alias_method '/pair-leaderboard', :show_leaderboard

        def top_10_leaderboard
          User.where(team_id: data.team_id)
              .order(total_points: :desc).limit(10)
        end

        def leaderboard_response
          response = [
            {
              "type": 'section',
              "text": { "type": 'mrkdwn', "text": '*Pair Leaderboard*' }
            },
            {
              "type": 'divider'
            }
          ]

          top_10_leaderboard.each_with_index do |user, index|
            response.push(
              {
                "type": 'section',
                "text": { "type": 'mrkdwn', "text": "#{index + 1}. #{user.user_name} - #{user.total_points.to_i} points" }
              },
              "type": 'divider'
            )
          end
          response.to_json
        end
      end
    end
  end
end
