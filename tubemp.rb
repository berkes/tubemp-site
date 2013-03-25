require 'sinatra'
require File.join(File.dirname(__FILE__), 'lib', 'youtube')

get '/:id' do
  yt = YouTube.new params[:id]

  yt.img_tag
end
