# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherService do
  describe 'gets weather', vcr: 'denver_search' do
    let(:response) { described_class.forecast({ lat: 39.7392358, lon: -104.990251 }) }

    it 'as array of days' do
      expect(response).to be_a(Hash)
    end

    describe 'with keys' do
      it 'list' do
        expect(response[:list]).to all(have_key(:dt))
      end

      it 'address' do
        expect(response[:list]).to all(have_key(:main))
      end
    end
  end

  describe 'sad path' do
    it 'errors gracefully with bad search' do
      response = described_class.forecast('Nonexistent')
      expect(response).to be_nil
    end

    it 'errors gracefully with blank search' do
      response = described_class.forecast
      expect(response).to be_nil
    end

    it 'errors gracefully with nil search' do
      response = described_class.forecast(nil)
      expect(response).to be_nil
    end

    it 'errors gracefully with empty search' do
      response = described_class.forecast({})
      expect(response).to be_nil
    end
  end
end
