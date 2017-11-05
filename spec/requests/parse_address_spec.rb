require 'spec_helper'

describe 'Parse Address Api' do
  it 'works' do
    get '/parse_address'
    expect(last_response.status).to be_equal(200)
  end
end