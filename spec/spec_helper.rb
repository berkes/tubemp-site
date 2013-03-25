require 'rack/test'
require File.expand_path File.join('../../tubemp.rb'), __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end

  def root_path()
    Pathname.new(File.realpath(File.join(File.dirname(__FILE__), '..')))
  end
end

RSpec.configure { |c| c.include RSpecMixin }
