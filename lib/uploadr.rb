require 'flickraw'
require 'parseconfig'
require 'celluloid'

require 'uploadr/version'

require 'uploadr/queue'
require 'uploadr/worker'
require 'uploadr/config'
require 'uploadr/bar'
require 'uploadr/log'

module Uploadr
  extend Uploadr::Config

  FlickRaw.api_key = ENV['FLICKR_API_KEY'] || "3863ad4bbc95758077ee8709de72752f"
  FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET'] || "3ce6eaa025d9a699"

  # Your code goes here...
end
