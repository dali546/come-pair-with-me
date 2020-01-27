$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load

require 'come_pair_with_me'
require 'lib/web'

Thread.new do
  begin
    ComePairWithMe::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run ComePairWithMe::Web
