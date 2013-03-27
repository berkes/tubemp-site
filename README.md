![tubemp](https://raw.github.com/berkes/tubemp/develop/public/img/logo.png)

> Nuke all the privacy-bugs from YouTube embeds

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

## Installation

### The quick way

1. `git clone https://github.com/berkes/tubemp.git`
1. `cd tubemp`
1. `bundle install`
1. `ruby tubemp.rb`
1. Open a browser and visit localhost:4567

In some near future, this project will be made into a gem, which
simplifies the installation and running greatly.

### The long way (nginx and passenger)

todo.

## Author and Contributors

[Bèr `berkes` Kessels](http://berk.es)

## Requirements

Bundler installs everything, but for reference:

* Sinatra
* RMagick
* [video_info](https://rubygems.org/gems/video_info) by Thibaud Guillaume-Gentil
* rspec for testing and development

## TODOS
* Write this README.
* Write installation instructions.
* Make a gem into this, allowing a simple `gem install tubemp && tubemp`
  to run your own server.
* Improve the Copy/pasting; auto-select, copy-to-clipboard button.
* Introduce a JSON-API.
* Make a wordpress and Drupal module, using that API.
