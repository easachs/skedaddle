# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParkService do
  it 'gets parks', vcr: 'denver_parks' do
    response = described_class.parks_near({ lat: 39.740959, lon: -104.985798 })
    response.each_value do |park|
      expect(park).to have_key(:name)
      expect(park).to have_key(:city)
      expect(park).to have_key(:state)
      expect(park).to have_key(:country)
      expect(park).to have_key(:description)
      expect(park).to have_key(:directions)
      expect(park).to have_key(:lat)
      expect(park).to have_key(:lon)
      expect(park).to have_key(:activities)
    end
  end

  it 'can sad path', vcr: 'bad_parks' do
    response = described_class.parks_near({ lat: nil, lon: nil })
    expect(response).to eq({
                             code: 'invalid_input',
                             message: 'For geo search, lat, lon, and radius must all be non-zero.',
                             data: {
                               status: 404
                             }
                           })
  end
end
