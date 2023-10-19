# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AirportFacade do
  it 'returns airports', vcr: 'denver_airports' do
    airports = described_class.airports_near({ lat: 39.740959, lon: -104.985798 })
    expect(airports).to be_all(AirportPoro)
  end

  describe 'sad path' do
    it 'errors gracefully with bad search' do
      airports = described_class.airports_near('Nonexistent')
      expect(airports).to be_nil
    end

    it 'errors gracefully with blank search' do
      airports = described_class.airports_near('')
      expect(airports).to be_nil
    end

    it 'errors gracefully with nil search' do
      airports = described_class.airports_near(nil)
      expect(airports).to be_nil
    end

    it 'errors gracefully with empty search' do
      airports = described_class.airports_near({})
      expect(airports).to be_nil
    end
  end
end
