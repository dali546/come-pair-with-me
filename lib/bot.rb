module ComePairWithMe
  class Bot < SlackRubyBot::Bot
    command /pair/ do |client, data, match|
      client.say(text: '{"blocks": [
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "A person has requested to pair for such and such a reason"
                },
                "block_id": "text1"
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "Click to accept their Pairing Request"
                },
                "accessory": {
                    "type": "button",
                    "text": {
                        "type": "plain_text",
                        "text": "I\'ll Help",
                        "emoji": true
                    },
                    "value": "click_me_123"
                }
            }
        ]
    }', channel: data.channel)
    end
  end
end
