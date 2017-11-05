require 'sinatra'
require 'geocoder'

get '/parse_address' do
  content_type :json

  address = params[:address].to_s.strip
  Geocoder.search(address).first&.address.to_json
end
