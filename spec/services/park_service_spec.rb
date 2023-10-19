# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParkService do
  describe 'gets parks', vcr: 'denver_parks' do
    let(:response) { described_class.parks_near({ lat: 39.740959, lon: -104.985798 }) }

    it 'as hash with parks array' do
      expect(response).to be_a(Hash)
    end

    describe 'with keys' do
      it 'name' do
        expect(response.values).to all(have_key(:name))
      end

      it 'city' do
        expect(response.values).to all(have_key(:city))
      end

      it 'state' do
        expect(response.values).to all(have_key(:state))
      end

      it 'country' do
        expect(response.values).to all(have_key(:country))
      end

      it 'description' do
        expect(response.values).to all(have_key(:description))
      end

      it 'directions' do
        expect(response.values).to all(have_key(:directions))
      end

      it 'activities' do
        expect(response.values).to all(have_key(:activities))
      end
    end
  end

  describe 'sad path' do
    it 'errors gracefully with bad search', vcr: 'bad_parks' do
      response = described_class.parks_near('Nonexistent')
      expect(response).to be_nil
    end

    it 'errors gracefully with blank search' do
      response = described_class.parks_near('')
      expect(response).to be_nil
    end

    it 'errors gracefully with nil search' do
      response = described_class.parks_near(nil)
      expect(response).to be_nil
    end

    it 'errors gracefully with empty search' do
      response = described_class.parks_near({})
      expect(response).to be_nil
    end
  end
end
