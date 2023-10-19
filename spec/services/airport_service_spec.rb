# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AirportService do
  describe 'gets airports', vcr: 'denver_airports' do
    let(:response) { described_class.airports_near({ lat: 39.740959, lon: -104.985798 }) }

    it 'as hash with airports array' do
      expect(response[:airports]).to be_a(Array)
    end

    describe 'with keys' do
      it 'name' do
        expect(response[:airports]).to all(have_key(:name))
      end

      it 'iata' do
        expect(response[:airports]).to all(have_key(:iata))
      end

      it 'city' do
        expect(response[:airports]).to all(have_key(:city))
      end

      it 'state' do
        expect(response[:airports]).to all(have_key(:stateCode))
      end

      it 'country' do
        expect(response[:airports]).to all(have_key(:countryCode))
      end
    end
  end

  describe 'sad path' do
    it 'errors gracefully with bad search' do
      response = described_class.airports_near('Nonexistent')
      expect(response).to be_nil
    end

    it 'errors gracefully with blank search' do
      response = described_class.airports_near('')
      expect(response).to be_nil
    end

    it 'errors gracefully with nil search' do
      response = described_class.airports_near(nil)
      expect(response).to be_nil
    end

    it 'errors gracefully with empty search' do
      response = described_class.airports_near({})
      expect(response).to be_nil
    end
  end
end
