require 'sinatra'
require 'json'
require File.join(File.dirname(__FILE__), 'lib', 'youtube')
require File.join(File.dirname(__FILE__), 'lib', 'thumbnail')
include ERB::Util

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

__END__
@@ layout
<!DOCTYPE html>
<!--[if IE 8]> 				 <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->

<head>
	<meta charset="utf-8" />
  <meta name="viewport" content="width=device-width" />
  <title>tubemp | <%= title %></title>
  <link rel="stylesheet" href="css/foundation.min.css" />
  <script src="js/vendor/custom.modernizr.js"></script>
</head>
<body>

	<div class="row">
		<div class="large-4 large-centered columns">
      <a href="/"><img src="img/logo.png" alt="tubemp logo" title="tubemp" class="logo" id="name" /></a>
		</div>
		<div class="large-6 large-centered columns">
      <h2 class="subheader"><small>YouTube embeds without third party trackers.</small></h2>
		</div>
	</div>

	<div class="row">
    <div class="large-12 columns">
      <hr />
      <h2><%= title %></h2>
    </div>
    <%= yield %>
	</div>

  <div class="footer row">
    <hr/>
    <div class="large-6 columns">
      <h2><small>Install it yourself...</small></h2>
      <p>Only the site who created the new embed-code can track your visitors, because this site serves the images. You probably don't want that either,
        so you probably want to <a href="https://github.com/berkes/tubemp#installation">install this tubemp</a> on your own server and domain, because it is <a href="https://github.com/berkes/tubemp">Open Source Software</a>.
      </p>
    </div>
    <div class="large-6 columns">
      <h2><small>...or, get me to install it for you.</small></h2>
      <p>You can find my contact details at <a href="http://berk.es/about.html">my website</a>. Or you can email me at <a href='ma&#105;lto&#58;be&#114;&#64;&#37;77%65&#98;&#37;73ch%&#55;5u%72&#46;c%6Fm'>be&#114;&#64;we&#98;schuu&#114;&#46;c&#111;m</a> to discuss the options.</p>
      <p>I can assist in anything, from getting a server or hoster to installation and customisation.</p>
    </div>
    <div class="large-12 columns">
     <p>The name tubemp is a play on the word <a href="https://en.wikipedia.org/wiki/Electromagnetic_pulse">EMP</a> and tube. Tube, referring to YouTube, EMP being a military (side)effect, which disables many electronic devises, also electronics that spy on you.</p> 
    </div>
  </div>

  <script>
  document.write('<script src=' +
  ('__proto__' in {} ? 'js/vendor/zepto' : 'js/vendor/jquery') +
  '.js><\/script>')
  </script>
  <script src="js/foundation.min.js"></script>
  <!--
  <script src="js/foundation/foundation.js"></script>
  <script src="js/foundation/foundation.forms.js"></script>
  -->
  <script>
    $(document).foundation();
  </script>

  <script type="text/javascript" src="zeroclipboard/ZeroClipboard.js"></script>
  <script>
    ZeroClipboard.setDefaults( { moviePath: '/zeroclipboard/ZeroClipboard.swf' } );
    $(document).ready(function() {
      /* Init zero-clipboard */
      $("input.copy_button").each(function() { new ZeroClipboard($(this)); });
    });
  </script>
</body>
</html>

@@ index
<div class="large-12 columns">
  <form method="get" action="/tags">
    <div class="row collapse">
      <div class="large-10 columns">
        <input type="text" name="v" placeholder="Youtube URL, ID, or embed-code">
      </div>
      <div class="large-2 columns">
        <input type="submit" class="button prefix" value="Create code" />
      </div>
    </div>
    <p class="message">For example <em>http://youtu.be/D80QdsFWdcQ</em>.</p>
  </form>
</div>
<div class="large-12 columns">
  <h2>How does it work?</h2>
</div>
<div class="large-4 columns">
  <div class="panel">
  <h2>1. <small>Provide the YouTube-code</small></h2>
  <p>Paste your originial YouTube embed-code, the ID or the video URL in the field above, and press the button.</p>
  <p>tubemp detects what video you want, downloads the thumbnail for it and re-creates a thumbnail from it.</p>
  <p>There is a simple <a href="https://github.com/berkes/tubemp#json">JSON API version</a></p>
  </div>
</div>
<div class="large-4 columns"><div class="panel">
  <h2>2. <small>tubemp creates an image that looks like a youtube-player</small></h2>
  <p>Copy and paste the code you get onto your site. You can either choose to place a simple image, or one that has a YouTube play icon sticked to it.<br/>
  This code links to the original video-page on YouTube. The image is served from the tubemp server and domain.
  </p>
  </div>
</div>
<div class="large-4 columns"><div class="panel">
  <h2>3. <small>Third party trackers?</small></h2>
  <p>When you place the default YouTube-embed-code on your site, Google (who owns YouTube) can, and will, track all the visitors of <em>your</em> site!<br />
  You, or your users may not like that. In many countries there are even laws and regulations that don't allow you to place things (like embed-codes, ads) on your
  site that allow <em>third parties</em> to track your visitors.<br />
  </p>
  </div>
</div>

@@ tags
<% tags.each do |key, tag| %>
  <div class="large-6 columns">
    <%= tag %><br />
    <div class="row collapse">
      <div class="large-10 columns">
        <input type="text" class="copy_value" id="copy_tag_<%= key %>" value="<%= html_escape tag %>" />
      </div>
      <div class="large-2 columns">
        <input type="button" class="button prefix copy_button" id="copy_button_<%= key %>" data-clipboard-target="copy_tag_<%= key %>" value="Copy" />
      </div>
    </div>
  </div>
<% end %>
<div class="large-12 columns">
  <a href="/">Create another one</a>
</div>

@@ not_found
  <div class="large-12 columns">
    Youtube video with id <em><%=h id %></em> not found.
  </div>

