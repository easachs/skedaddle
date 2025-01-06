# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaceFacade do
  describe 'near' do
    it 'returns places', vcr: 'denver_search' do
      places = described_class.near({ lat: 39.7392358, lon: -104.990251 }, 'hospital')
      expect(places).to be_all(PlacePoro)
    end

    describe 'sad path' do
      it 'errors gracefully with bad search' do
        places = described_class.near('Nonexistent')
        expect(places).to be_nil
      end

      it 'errors gracefully with blank search' do
        places = described_class.near('')
        expect(places).to be_nil
      end

      it 'errors gracefully with nil search' do
        places = described_class.near(nil)
        expect(places).to be_nil
      end

      it 'errors gracefully with empty search' do
        places = described_class.near({})
        expect(places).to be_nil
      end
    end
  end
end
