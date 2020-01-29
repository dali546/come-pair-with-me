module ComePairWithMe
  class Bot < SlackRubyBot::Bot
    command /^pair$/ do |client, data, match|
      client.say(text: 'I will Pair With You', channel: data.channel)
    end
  end
end
