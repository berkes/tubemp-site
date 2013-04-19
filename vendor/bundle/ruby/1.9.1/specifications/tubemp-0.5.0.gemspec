# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "tubemp"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["B\u{e8}r `berkes` Kessels"]
  s.date = "2013-04-09"
  s.description = "tubemp is a tiny web-application which creates and serves thumbnail-images from YouTube embed-codes. These images link to the video and look like embedded videos."
  s.email = "ber@webschuur.com"
  s.executables = ["tubemp"]
  s.files = ["bin/tubemp"]
  s.homepage = "http://tubemp.webschuur.com"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Tubemp. YouTube embeds without third party trackers."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, ["~> 1.4"])
      s.add_runtime_dependency(%q<rmagick>, ["~> 2.13"])
      s.add_runtime_dependency(%q<video_info>, ["~> 1.1"])
      s.add_runtime_dependency(%q<capistrano>, ["~> 2.14"])
      s.add_runtime_dependency(%q<json>, ["~> 1.7.7"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13"])
      s.add_development_dependency(%q<rack-test>, ["~> 0.6"])
    else
      s.add_dependency(%q<sinatra>, ["~> 1.4"])
      s.add_dependency(%q<rmagick>, ["~> 2.13"])
      s.add_dependency(%q<video_info>, ["~> 1.1"])
      s.add_dependency(%q<capistrano>, ["~> 2.14"])
      s.add_dependency(%q<json>, ["~> 1.7.7"])
      s.add_dependency(%q<rspec>, ["~> 2.13"])
      s.add_dependency(%q<rack-test>, ["~> 0.6"])
    end
  else
    s.add_dependency(%q<sinatra>, ["~> 1.4"])
    s.add_dependency(%q<rmagick>, ["~> 2.13"])
    s.add_dependency(%q<video_info>, ["~> 1.1"])
    s.add_dependency(%q<capistrano>, ["~> 2.14"])
    s.add_dependency(%q<json>, ["~> 1.7.7"])
    s.add_dependency(%q<rspec>, ["~> 2.13"])
    s.add_dependency(%q<rack-test>, ["~> 0.6"])
  end
end
