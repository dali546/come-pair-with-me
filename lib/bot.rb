module ComePairWithMe
  class Bot < SlackRubyBot::Bot
    match /^pair$/ do |client, data, match|
      client.say(text: 'I will Pair With You', channel: data.channel)
    end

    command 'test' do |client, date, match|
      client.say(channel: data.channel, text: 'Test Command')
    end
  end
end