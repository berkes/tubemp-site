require 'sinatra'
require 'json'
require File.join(File.expand_path(File.dirname(__FILE__)), 'youtube')
require File.join(File.expand_path(File.dirname(__FILE__)), 'thumbnail')
include ERB::Util

class Tubemp < Sinatra::Application
  # when using from Rackup
  enable :inline_templates

  get '/tags.?:format?' do
    yt  = YouTube.new params[:v]
    uri = URI(request.base_url)

    if yt.valid?
      case params[:format]
      when "json"
        content_type :json
        yt.tags(uri).to_json
      else
        erb :tags, :locals => {:tags => yt.tags(uri), :title => yt.title}
      end
    else # not valid
      not_found erb(:not_found, :locals => { :title => "Not Found", :id => params[:v]} )
    end
  end

  get '/' do
    erb :index, :locals => { :title => "YouTube embeds without third party trackers." }
  end
end
