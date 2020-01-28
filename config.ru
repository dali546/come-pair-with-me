$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load

require 'come_pair_with_me'
require 'lib/web'

Thread.new do
  ComePairWithMe::Bot.run
rescue StandardError => e
  warn "ERROR: #{e}"
  warn e.backtrace
  raise e
end

run ComePairWithMe::Web
