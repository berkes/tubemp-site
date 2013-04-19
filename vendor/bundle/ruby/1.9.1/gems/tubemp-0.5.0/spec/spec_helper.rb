require 'rack/test'
require File.join(File.dirname(__FILE__), '..', 'lib', 'tubemp.rb')

module RSpecMixin
  include Rack::Test::Methods
  def app() Tubemp end

  def root_path()
    Pathname.new(File.realpath(File.join(File.dirname(__FILE__), '..')))
  end

  def stub_info
    info = mock("video");
    info.stub(:title).and_return("Tony Tribe , Red Red Wine")
    info.stub(:thumbnail_large).and_return("http://i.ytimg.com/vi/D80QdsFWdcQ/hqdefault.jpg")
    VideoInfo.stub(:get).and_return info
  end

end

RSpec.configure { |c| c.include RSpecMixin }
