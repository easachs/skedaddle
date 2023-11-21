# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParkFacade do
  it 'returns parks', vcr: 'denver_parks' do
    parks = described_class.near({ lat: 39.740959, lon: -104.985798 })
    expect(parks).to be_all(ParkPoro)
  end

  describe 'sad path' do
    it 'errors gracefully with bad search' do
      parks = described_class.near('Nonexistent')
      expect(parks).to be_nil
    end

    it 'errors gracefully with blank search' do
      parks = described_class.near('')
      expect(parks).to be_nil
    end

    it 'errors gracefully with nil search' do
      parks = described_class.near(nil)
      expect(parks).to be_nil
    end

    it 'errors gracefully with empty search' do
      parks = described_class.near({})
      expect(parks).to be_nil
    end
  end
end
