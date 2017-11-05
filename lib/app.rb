require 'address_parser'

class App < Sinatra::Application
  get '/parse_address' do
    content_type :json

    parser = AddressParser.new(params[:address])
    parser.parse

    parser.result.to_json
  end
end
