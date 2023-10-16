# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ParkFacade' do
  it 'returns parks', vcr: 'denver_parks' do
    parks = ParkFacade.parks_near({ lat: 39.740959, lon: -104.985798 })
    expect(parks).to be_a(Array)
    expect(parks).to be_all(ParkPoro)
    expect(parks.length).to eq(3)
  end

  it 'errors gracefully', vcr: 'bad_parks' do
    parks = ParkFacade.parks_near({ lat: nil, lon: nil })
    expect(parks).to eq([])
  end
end
