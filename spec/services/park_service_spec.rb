# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParkService do
  describe 'gets parks', vcr: 'denver_search' do
    key = ENV.fetch('RAPID_API_KEY', nil)
    let(:response) { described_class.new(key).near({ lat: 39.7392358, lon: -104.990251 }) }

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
    it 'errors gracefully with bad search' do
      response = described_class.new.near('Nonexistent')
      expect(response).to be_nil
    end

    it 'errors gracefully with blank search' do
      response = described_class.new.near('')
      expect(response).to be_nil
    end

    it 'errors gracefully with nil search' do
      response = described_class.new.near(nil)
      expect(response).to be_nil
    end

    it 'errors gracefully with empty search' do
      response = described_class.new.near({})
      expect(response).to be_nil
    end
  end
end
