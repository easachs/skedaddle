# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AirportPoro do
  attributes = { fs: 'DEN',
                 iata: 'DEN',
                 icao: 'KDEN',
                 faa: 'DEN',
                 name: 'Denver International Airport',
                 street1: '8500 Pena Boulevard',
                 city: 'Denver',
                 cityCode: 'DEN',
                 stateCode: 'CO',
                 postalCode: '80249-6340',
                 countryCode: 'US',
                 countryName: 'United States',
                 regionName: 'North America',
                 timeZoneRegionName: 'America/Denver',
                 weatherZone: 'COZ040',
                 localTime: '2023-10-20T13:29:52.752',
                 utcOffsetHours: -6.0,
                 latitude: 39.851382,
                 longitude: -104.673098,
                 elevationFeet: 5389,
                 classification: 1,
                 active: true,
                 weatherUrl: 'https://api.flightstats.com/flex/weather/rest/v1/json/all/DEN?codeType=fs',
                 delayIndexUrl: 'https://api.flightstats.com/flex/delayindex/rest/v1/json/airports/DEN?codeType=fs' }

  let(:airport) { described_class.new(attributes) }

  it 'exists' do
    expect(airport).to be_a(described_class)
  end

  describe 'has attributes' do
    it 'name' do
      expect(airport.name).to eq('Denver International Airport (DEN)')
    end

    it 'address1' do
      expect(airport.address1).to eq('8500 Pena Boulevard')
    end

    it 'address2' do
      expect(airport.address2).to eq('Denver, CO, US')
    end
  end

  describe 'errors gracefully' do
    let(:bad_airport) { described_class.new({}) }

    it 'name' do
      expect(bad_airport.name).to be_nil
    end

    it 'address1' do
      expect(bad_airport.address1).to be_nil
    end

    it 'address2' do
      expect(bad_airport.address2).to be_nil
    end
  end
end
