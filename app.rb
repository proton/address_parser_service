require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)
lib_dir = File.expand_path(File.dirname(__FILE__))
$:.unshift(lib_dir) unless $:.include?(lib_dir)

require 'address_parser'

get '/parse_address' do
  content_type :json

  parser = AddressParser.new(params[:address])
  parser.parse

  parser.result.to_json
end
