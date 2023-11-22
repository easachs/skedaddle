# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'gets geocode', vcr: 'denver_geocode' do
    let(:response) { described_class.geocode('Denver') }

    it 'as hash with parks array' do
      expect(response[:data]).to be_a(Array)
    end

    describe 'with keys' do
      it 'label' do
        expect(response[:data]).to all(have_key(:label))
      end

      it 'locality' do
        expect(response[:data]).to all(have_key(:locality))
      end

      it 'region' do
        expect(response[:data]).to all(have_key(:region))
      end

      it 'country' do
        expect(response[:data]).to all(have_key(:country))
      end

      it 'latitude' do
        expect(response[:data]).to all(have_key(:latitude))
      end

      it 'longitude' do
        expect(response[:data]).to all(have_key(:longitude))
      end
    end
  end

  describe 'sad path' do
    it 'errors gracefully with bad search', vcr: 'bad_geocode' do
      response = described_class.geocode('Nonexistent')
      expect(response[:data]).to eq([])
    end

    it 'errors gracefully with blank search' do
      response = described_class.geocode('')
      expect(response).to be_nil
    end

    it 'errors gracefully with nil search' do
      response = described_class.geocode(nil)
      expect(response).to be_nil
    end

    it 'errors gracefully with empty search' do
      response = described_class.geocode({})
      expect(response).to be_nil
    end
  end
end
