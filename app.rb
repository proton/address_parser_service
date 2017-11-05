require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

get '/parse_address' do
  content_type :json

  address = params[:address].to_s.strip
  Geocoder.search(address).first&.address.to_json
  {:error=>"no address"}.to_json
end
