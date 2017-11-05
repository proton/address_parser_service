class AddressParser
  attr_reader :address, :result, :error, :geo

  def initialize(address)
    @address = address.to_s.strip
  end

  def parse
    return finish_with_error('no address') if address.empty?

    @geo = Geocoder.search(address).first
    return finish_with_error('not found') unless geo

    true
  end

  def successful?
    error.nil?
  end

  def result
    if error
      { error: error }
    else
      geo_result
    end
  end

  private

  def finish_with_error(error)
    @error = error
    false
  end

  def geo_result
    route_info = geo.address_components_of_type(:route).first
    street = route_info['long_name'] if route_info
    sublocality_info = geo.address_components_of_type(:sublocality).first
    district = sublocality_info['long_name'] if sublocality_info

    @result = {
      street_number: geo.street_number,
      street: street,
      district: district,
      city: geo.city,
      state: geo.state,
      country: geo.country
    }
  end
end