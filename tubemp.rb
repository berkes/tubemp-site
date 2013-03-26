require 'sinatra'
require File.join(File.dirname(__FILE__), 'lib', 'youtube')

include ERB::Util

get '/tags' do
  yt = YouTube.new params[:v], {:base_url => request.base_url }

  erb :tags, :locals => {:tags => yt.tags, :title => yt.title}
end

get '/' do
  erb :index, :locals => { :title => "Create bug-free embed code" }
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
  <link rel="stylesheet" href="css/normalize.css" />
  <link rel="stylesheet" href="css/foundation.css" />
  <script src="js/vendor/custom.modernizr.js"></script>
</head>
<body>

	<div class="row">
		<div class="large-4 large-centered columns">
      <a href="/"><img src="img/logo.png" alt="tubemp logo" title="tubemp" class="logo" id="name" /></a>
		</div>
		<div class="large-6 large-centered columns">
      <h2 class="subheader"><small>Nuke all the privacy-bugs from youtube embeds</small></h2>
		</div>
	</div>

	<div class="row">
    <div class="large-12 columns">
      <hr />
      <h2><%= title %></h2>
    </div>
    <%= yield %>
	</div>

  <script>
  document.write('<script src=' +
  ('__proto__' in {} ? 'js/vendor/zepto' : 'js/vendor/jquery') +
  '.js><\/script>')
  </script>
  <script src="js/foundation.min.js"></script>
  <!--
  <script src="js/foundation/foundation.js"></script>
  <script src="js/foundation/foundation.alerts.js"></script>
  <script src="js/foundation/foundation.clearing.js"></script>
  <script src="js/foundation/foundation.cookie.js"></script>
  <script src="js/foundation/foundation.dropdown.js"></script>
  <script src="js/foundation/foundation.forms.js"></script>
  <script src="js/foundation/foundation.joyride.js"></script>
  <script src="js/foundation/foundation.magellan.js"></script>
  <script src="js/foundation/foundation.orbit.js"></script>
  <script src="js/foundation/foundation.placeholder.js"></script>
  <script src="js/foundation/foundation.reveal.js"></script>
  <script src="js/foundation/foundation.section.js"></script>
  <script src="js/foundation/foundation.tooltips.js"></script>
  <script src="js/foundation/foundation.topbar.js"></script>
  -->
  <script>
    $(document).foundation();
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
        <input type="submit" class="button prefix" value="Remove the bugs" />
      </div>
    </div>
  </form>
</div>
<div class="large-12 columns">
  <h2>How does it work?</h2>
</div>
<div class="large-4 columns">
<div class="panel">
  <h2>1. <small>Provide the YouTube-code</small></h2>
  <p>Paste your originial YouTube embed-code, the ID or the video URL in the field above, and press the button.</p>
  <p>tubemp is a play on the word <a href="">EMP</a> and tube. Tube, referring to YouTube, EMP being a military (side)effect, which disables many electronic devises, also electronics that spy on you.</p>
</div>
</div>
<div class="large-4 columns"><div class="panel">
  <h2>2. <small>tubemp creates an image that looks like a youtube-player</small></h2>
  <p>Copy and paste the code you get onto your site. You can either choose to place a simple image, or one that has a "YouTube" play icon on it.<br/>
  This code we provide, links to the original video-page on YouTube. The image is served from the tubemp server and domain.
  </p>
  <p>Now only the site who created the new embed-code can track your visitors! You probably don't want that either,
  so you probably want to <a href="">install this tubemp</a> on your own server and domain, because it is <a href="">Open Source Software</a>. Or you can <a href="">have me do that installation for you</a>
  </p>
  </div>
</div>
<div class="large-4 columns"><div class="panel">
  <h2>3. <small>Bug-free?</small></h2>
  <p>When you place the default YouTube-embed-code on your site, Google (who owns YouTube) can, and will, track all the visitors of <em>your</em> site!<br />
  You, or your users may not like that. In many countries there are even laws and regulations that don't allow you to place things (like embed-codes, ads) on your
  site that allow <em>third parties</em> to track your visitors.<br />
  </p>
  </div>
</div>

@@ tags
<% tags.each do |tag| %>
  <div class="large-6 columns">
    <%= tag %><br />
    <input type="text" value="<%= html_escape tag %>" />
  </div>
<% end %>
<div class="large-12 columns">
  <a href="/">Create another one</a>
</div>
