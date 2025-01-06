# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'returns weather', vcr: 'denver_search' do
    let(:weather) { described_class.forecast({ lat: 39.7392358, lon: -104.990251 }) }

    it 'as array of days' do
      expect(weather).to be_a(Array)
    end

    it 'with days as hashes' do
      expect(weather).to be_all(Hash)
    end
  end

  describe 'sad path' do
    it 'errors gracefully with bad search' do
      weather = described_class.forecast('Nonexistent')
      expect(weather).to be_nil
    end

    it 'errors gracefully with blank search' do
      weather = described_class.forecast
      expect(weather).to be_nil
    end

    it 'errors gracefully with nil search' do
      weather = described_class.forecast(nil)
      expect(weather).to be_nil
    end

    it 'errors gracefully with empty search' do
      weather = described_class.forecast({})
      expect(weather).to be_nil
    end
  end
end
