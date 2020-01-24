$LOAD_PATH.unshift(File.dirname(__FILE__))
require './come_pair_with_me.rb'
require 'dotenv'
require 'rubygems'
require 'bundler'
require 'lib/web.rb'
require 'lib/bot'

Dotenv.load
Bundler.require

ComePairWithMe::Bot.run

run ComePairWithMe::Web
