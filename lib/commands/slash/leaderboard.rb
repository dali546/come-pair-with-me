# frozen_string_literal: true

module ComePairWithMe
  module Commands
    module Slash
      module Leaderboard
        def show_leaderboard(payload)
          client.chat_postEphemeral(
            channel: payload.channel_id,
            attachments: %([{"pretext": "pre-hello", "text": "text-world"}]),
            text: 'Pair Leaderboard',
            blocks: leaderboard_response(payload.team_id),
            user: payload.user_id
          )
        end
        alias_method '/pair-leaderboard', :show_leaderboard

        def top_10_leaderboard(team_id)
          User.where(team_id: team_id).order(total_points: :desc).limit(10)
        end

        def leaderboard_response(team_id)
          response = [
            {
              "type": 'section',
              "text": {
                "type": 'mrkdwn',
                "text": '*Pair Leaderboard*'
              }
            },
            {
              "type": 'divider'
            }
          ]

          top_10_leaderboard(team_id).each_with_index do |user, index|
            response.push({
                            "type": 'section',
                            "text": {
                              "type": 'mrkdwn',
                              "text": "#{index + 1}. #{user.user_name} - #{user.total_points.to_i} points"
                            }
                          },
                          "type": 'divider')
          end
          response.to_json
        end
      end
    end
  end
end
