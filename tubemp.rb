require 'sinatra'
require File.join(File.dirname(__FILE__), 'lib', 'youtube')

include ERB::Util

get '/:id' do
  yt = YouTube.new params[:id]

  image_tags = [yt.img_tag, yt.img_tag(true)]
  title      = "title here"

  erb :index, :locals => {:image_tags => image_tags, :title => title}
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
		<div class="large-12 columns">
      <h1>tub<strong class="highlight">emp</strong></h1>
			<hr />
		</div>
	</div>

	<div class="row">
		<div class="large-12 columns">
			<h2><%= title %></h2>
      <%= yield %>
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
<% image_tags.each do |image_tag| %>
  <div class="large-6 columns">
    <%= image_tag %><br />
    <input type="text" disabled="disabled" value="<%= html_escape image_tag %>" />
  </div>
<% end %>
