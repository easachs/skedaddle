# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaceService do
  describe 'gets new places', vcr: 'denver_search' do
    let(:response) { described_class.near({ lat: 39.740959, lon: -104.985798 }, 'hospital') }

    it 'as hash with places array' do
      expect(response[:places]).to be_a(Array)
    end

    describe 'with keys' do
      it 'name' do
        expect(response[:places]).to all(have_key(:displayName))
      end

      it 'address' do
        expect(response[:places]).to all(have_key(:formattedAddress))
      end
    end
  end

  describe 'sad path' do
    it 'errors gracefully with bad search' do
      response = described_class.near('Nonexistent')
      expect(response).to be_nil
    end

    it 'errors gracefully with blank search' do
      response = described_class.near('')
      expect(response).to be_nil
    end

    it 'errors gracefully with nil search' do
      response = described_class.near(nil)
      expect(response).to be_nil
    end

    it 'errors gracefully with empty search' do
      response = described_class.near({})
      expect(response).to be_nil
    end
  end
end
