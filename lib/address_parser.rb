require 'geocoder'

class AddressParser
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def parse
    # Geocoder.search(address).first&.address.to_json
  end

  def result
    {:error=>"no address"}
  end
end