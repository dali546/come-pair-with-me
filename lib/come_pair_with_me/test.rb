module ComePairWithMe
  class Bot < SlackRubyBot::Bot
    command 'test' do |client, date, match|
      client.say(channel: data.channel, text: 'Test Command')
    end
  end
end