![tubemp](https://raw.github.com/berkes/tubemp/develop/public/img/logo.png)

> YouTube embeds without third party trackers.

tubemp is a tiny web-application which creates and serves thumbnail-images from YouTube embed-codes. These images link to the video and look like embedded videos.

It offers a replacement for embedding YouTube videos on your site. A
replacement without third-party cookies and tracking "bugs" following your
visitors.

Many countries (most notably the E.U-countries) don't allow third party
trackers on many of their sites. Many site-owners don't want to place
content on their websites that allows companies like Google to track
their visitors. 

Placing an image that *looks* like a YouTube embed, but served from your
own domain, is a good solution for all this.

This tiny application aids in that.

## Features

* Simple, friendly web-interface.
* Bookmarkable: tubemp.example.com/tags?v=D80QdsFWdcQ
* JSON API: tubemp.example.com/tags.json?v=D80QdsFWdcQ

# Demo and examples

A demo installation can be found at http://tubemp.webschuur.com. NOTE
that this is a demo; images will be wiped; when you include them from
this service on your website, you will see broken images on your website at some point.

A hosted version is being developed and will replace the demo.

![Example](http://i.imgur.com/SI4zMrF.png)

Example code:

`<a href="http://www.youtube.com/watch?v=D80QdsFWdcQ"><img src="http://tubemp.webschuur.com/thumbs/D8/D80QdsFWdcQ_overlay.png" alt="Tony Tribe , Red Red Wine"/></a>`

## Installation

### The quick way

1. `$ gem install tubemp`
1. `$ tubemp`
1. Open a browser and visit localhost:4567

### The long way (nginx and passenger)

todo.

## JSON

You can get the result as JSON by adding `.json` to the tags page:

    curl http://tubemp.example.com/tags.json?v=<youtube-id>

This returns a hash with the variations of the tags. For example, in PHP:

    php > print_r(json_decode(file_get_contents("http://tubemp.example.com/tags.json?v=D80QdsFWdcQ")));
    stdClass Object
    (
        [basic] => <a href="http://www.youtube.com/watch?v=D80QdsFWdcQ"><img src="http://localhost:9393/thumbs/D80QdsFWdcQ.png" alt="Tony Tribe , Red Red Wine"/></a>
        [overlay] => <a href="http://www.youtube.com/watch?v=D80QdsFWdcQ"><img src="http://localhost:9393/thumbs/D80QdsFWdcQ_overlay.png" alt="Tony Tribe , Red Red Wine"/></a>
    )

## Author and Contributors

[Bèr `berkes` Kessels](http://berk.es)

## Requirements

Bundler installs everything, but for reference:

* Sinatra
* RMagick
* [video_info](https://rubygems.org/gems/video_info) by Thibaud Guillaume-Gentil
* rspec for testing and development

## TODOS
* Write installation instructions for nginx
* Make a wordpress and Drupal module, using the JSON API.
* Make the gem mountable; current gem is a hack and e.g. stores the
  cached images in the gem-dir.
