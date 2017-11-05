require 'app'

include Rack::Test::Methods
def app() App end

shared_examples 'parse address' do
  it 'returns correct response' do
    get '/parse_address', address: address

    expect(response.status).to eq(200)
    expect(response_json).to eq(result)
  end
end

describe 'Parse Address Api' do
  subject(:response) { last_response }
  subject(:response_json) { JSON.parse(response.body, symbolize_names: true) }

  context 'good address' do
    let(:address) { 'Berlin Julie-Wolfthorn-Str. 1' }
    let(:result) do
      {
        street_number: '1',
        street: 'Julie-Wolfthorn-Straße',
        district: 'Mitte',
        city: 'Berlin',
        state: 'Berlin',
        country: 'Germany'
      }
    end

    include_examples 'parse address'
  end

  context 'bad address' do
    let(:address) { 'fsdfdlfsdfsd' }
    let(:error) { 'not found' }
    let(:result) { { error: error } }

    include_examples 'parse address'
  end

  context 'no address' do
    let(:address) { nil }
    let(:error) { 'no address' }
    let(:result) { { error: error } }

    include_examples 'parse address'
  end
end