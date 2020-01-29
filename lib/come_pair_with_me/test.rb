module ComePairWithMe
  class Bot < SlackRubyBot::Bot
    command /test/ do |client, data, match|
      client.say(channel: data.channel, text: 'Test Command')
    end
  end
end