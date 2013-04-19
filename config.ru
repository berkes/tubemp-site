require 'rubygems'
require 'sinatra'

set :environment, ENV['RACK_ENV'].to_sym

require 'tubemp'

run Tubemp
