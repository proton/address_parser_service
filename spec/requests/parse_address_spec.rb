require 'spec_helper'

describe 'Parse Address Api' do
  subject(:response) { last_response }
  subject(:response_json) { JSON.parse(response.body, symbolize_names: true) }

  context 'good address' do
    let(:address) { 'Berlin Julie-Wolfthorn-Str. 1' }

    it 'returns correct answer' do
      get '/parse_address', address: address

      result = {
        street_number: '1',
        street: 'Julie-Wolfthorn-Straße',
        district: 'Mitte',
        city: 'Berlin',
        state: 'Berlin',
        country: 'Germany'
      }

      expect(response.status).to eq(200)
      expect(response_json).to eq(result)
    end
  end

  context 'bad address' do
    let(:address) { 'fsdfdlfsdfsd' }

    it 'returns answer with error' do
      get '/parse_address', address: address

      result = { error: 'not found' }

      expect(response.status).to eq(200)
      expect(response_json).to eq(result)
    end
  end

  context 'no address' do
    it 'returns answer with error' do
      get '/parse_address'

      result = { error: 'no address' }

      expect(response.status).to eq(200)
      expect(response_json).to eq(result)
    end
  end
end