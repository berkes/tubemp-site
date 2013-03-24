require 'rack/test'

require File.expand_path File.join('../../tubemp.rb'), __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sintra::Application end
end

Rspec.configure { |c| c.include RSpecMixin }
