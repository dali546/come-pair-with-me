# frozen_string_literal: true

module ComePairWithMe
  module Actions
    module Command
      module Leaderboard
        def show_leaderboard
          client.chat_postEphemeral(
            channel: data.channel_id,
            text: 'Pair Leaderboard',
            blocks: leaderboard_response.to_json,
            user: data.user_id
          )
        end
        alias_method '/pair-leaderboard', :show_leaderboard

        def top_10
          User.where(team_id: data.team_id)
              .order(total_points: :desc).limit(10)
        end

        def leaderboard_response
          [
            BlockKit::Components::Section[text: '*Pair Leaderboard*'],
            BlockKit::Components::Divider[]
          ].concat(format_top_10)
        end

        def format_top_10
          top_10.flat_map.with_index do |user, index|
            [
              BlockKit::Components::Section[text: "#{index + 1}. #{user.user_name} - #{user.total_points.to_i} points"],
              BlockKit::Components::Divider[]
            ]
          end
        end
      end
    end
  end
end
