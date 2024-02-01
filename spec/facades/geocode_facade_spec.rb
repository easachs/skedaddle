# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodeFacade do
  describe 'returns', vcr: 'denver_search' do
    it 'search' do
      geocode = described_class.geocode('Denver')
      expect(geocode[:search]).to eq('Denver, CO, USA')
    end

    it 'city' do
      geocode = described_class.geocode('Denver')
      expect(geocode[:city]).to eq('Denver')
    end

    it 'region' do
      geocode = described_class.geocode('Denver')
      expect(geocode[:region]).to eq('Colorado')
    end

    it 'country' do
      geocode = described_class.geocode('Denver')
      expect(geocode[:country]).to eq('United States')
    end

    it 'lat' do
      geocode = described_class.geocode('Denver')
      expect(geocode[:lat]).to be_a(Float)
    end

    it 'lon' do
      geocode = described_class.geocode('Denver')
      expect(geocode[:lon]).to be_a(Float)
    end
  end

  describe 'sad path' do
    it 'errors gracefully with bad search', vcr: 'bad_geocode' do
      geocode = described_class.geocode('Nonexistent')
      expect(geocode).to be_nil
    end

    it 'errors gracefully with blank search' do
      geocode = described_class.geocode('')
      expect(geocode).to be_nil
    end

    it 'errors gracefully with nil search' do
      geocode = described_class.geocode(nil)
      expect(geocode).to be_nil
    end

    it 'errors gracefully with empty search' do
      geocode = described_class.geocode({})
      expect(geocode).to be_nil
    end
  end
end
