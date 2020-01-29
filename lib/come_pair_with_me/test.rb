module ComePairWithMe
  class Bot < SlackRubyBot::Bot
    command /test/ do |client, data, match|
      client.say(channel: data.channel, text: '{
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "A message *with some bold text* and _some italicized text_."
        }
      }')
    end
  end
end