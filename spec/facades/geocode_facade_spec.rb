# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GeocodeFacade' do
  it 'returns lat/lon', vcr: 'denver_geocode' do
    geocode = GeocodeFacade.geocode('Denver')
    expect(geocode).to be_a(Hash)
    expect(geocode[:lat]).to be_a(Float)
    expect(geocode[:lon]).to be_a(Float)
  end

  it 'errors gracefully', vcr: 'bad_geocode' do
    geocode = GeocodeFacade.geocode('Nonexistent')
    expect(geocode).to eq({ lat: nil, lon: nil })
  end
end
