# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodePoro do
  attributes = {
    results: [
      {
        address_components: [
          {
            long_name: 'Denver',
            short_name: 'Denver',
            types: %w[
              locality
              political
            ]
          },
          {
            long_name: 'Denver County',
            short_name: 'Denver County',
            types: %w[
              administrative_area_level_2
              political
            ]
          },
          {
            long_name: 'Colorado',
            short_name: 'CO',
            types: %w[
              administrative_area_level_1
              political
            ]
          },
          {
            long_name: 'United States',
            short_name: 'US',
            types: %w[
              country
              political
            ]
          }
        ],
        formatted_address: 'Denver, CO, USA',
        geometry: {
          bounds: {
            northeast: {
              lat: 39.91424689999999,
              lng: -104.6002959
            },
            southwest: {
              lat: 39.614431,
              lng: -105.109927
            }
          },
          location: {
            lat: 39.7392358,
            lng: -104.990251
          },
          location_type: 'APPROXIMATE',
          viewport: {
            northeast: {
              lat: 39.91424689999999,
              lng: -104.6002959
            },
            southwest: {
              lat: 39.614431,
              lng: -105.109927
            }
          }
        },
        navigation_points: [
          {
            location: {
              latitude: 39.7411148,
              longitude: -104.9879685
            }
          }
        ],
        place_id: 'ChIJzxcfI6qAa4cR1jaKJ_j0jhE',
        types: %w[
          locality
          political
        ]
      }
    ],
    status: 'OK'
  }

  let(:geocode) { described_class.new(attributes[:results].first) }

  it 'exists' do
    expect(geocode).to be_a(described_class)
  end

  describe 'has attributes' do
    it 'search' do
      expect(geocode.search).to eq('Denver, CO, USA')
    end

    it 'city' do
      expect(geocode.city).to eq('Denver')
    end

    it 'region' do
      expect(geocode.region).to eq('Colorado')
    end

    it 'country' do
      expect(geocode.country).to eq('United States')
    end

    it 'lat' do
      expect(geocode.lat).to eq(39.7392358)
    end

    it 'lon' do
      expect(geocode.lon).to eq(-104.990251)
    end

    it 'serialized' do
      expected = { search: 'Denver, CO, USA', city: 'Denver',
                   region: 'Colorado', country: 'United States',
                   lat: 39.7392358, lon: -104.990251 }
      expect(geocode.serialized).to eq(expected)
    end
  end

  describe 'errors gracefully' do
    let(:bad_geocode) { described_class.new({}) }

    it 'search' do
      expect(bad_geocode.search).to be_nil
    end

    it 'city' do
      expect(bad_geocode.city).to be_nil
    end

    it 'region' do
      expect(bad_geocode.region).to be_nil
    end

    it 'country' do
      expect(bad_geocode.country).to be_nil
    end

    it 'lat' do
      expect(bad_geocode.lat).to be_nil
    end

    it 'lon' do
      expect(bad_geocode.lon).to be_nil
    end
  end
end
