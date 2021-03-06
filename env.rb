require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

lib_dir = File.expand_path(File.dirname(__FILE__) + '/lib')
$:.unshift(lib_dir) unless $:.include?(lib_dir)

# Settings

GEOCODER_API_KEY = ENV['GEOCODER_API_KEY']
REDIS_HOST = ENV['REDIS_HOST'] || 'localhost'

Geocoder.configure(
  use_https: true,
  lookup: :google,
  api_key: ENV['GEOCODER_API_KEY'],
  cache: Redis.new(host: REDIS_HOST)
)