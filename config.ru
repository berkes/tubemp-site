require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'tubemp'

set :environment, ENV['RACK_ENV'].to_sym

run Tubemp
