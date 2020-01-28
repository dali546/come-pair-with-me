require 'clockwork'
require 'net/http'
class Nudge
  include Clockwork

  handler do |_job|
    puts 'Nudging Site'
    Net::HTTP.get('come-pair-with-me.herokuapp.com', '/')
    puts 'Nudge Complete'
  end

  every(5.minutes, 'Nudge')
end
