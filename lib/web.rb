require 'sinatra/base'

module ComePairWithMe
  class Web < Sinatra::Base
    get '/' do
      'Come Pair With Me Is Up'
    end
  end
end
