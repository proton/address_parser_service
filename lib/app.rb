require File.expand_path '../../env.rb', __FILE__
require 'address_parser'

get '/parse_address' do
  content_type :json

  parser = AddressParser.new(params[:address])
  parser.parse

  parser.result.to_json
end
