# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'gets geocode', vcr: 'denver_search' do
    let(:response) { described_class.geocode('Denver') }

    it 'as hash with geocode array' do
      expect(response[:results]).to be_a(Array)
    end

    describe 'with keys' do
      it 'address_components' do
        expect(response[:results]).to all(have_key(:address_components))
      end

      it 'formatted_address' do
        expect(response[:results]).to all(have_key(:formatted_address))
      end
    end

    describe 'with address' do
      let(:address_components) { response[:results][0][:address_components] }

      def expect_to_have_key(type, key)
        expect(address_components.find { |comp| comp[:types].include?(type) }).to have_key(key)
      end

      it 'city' do
        expect_to_have_key('locality', :long_name)
      end

      it 'region' do
        expect_to_have_key('administrative_area_level_1', :long_name)
      end

      it 'country' do
        expect_to_have_key('country', :long_name)
      end

      it 'latitude' do
        expect(response[:results][0][:geometry][:location]).to have_key(:lat)
      end

      it 'longitude' do
        expect(response[:results][0][:geometry][:location]).to have_key(:lng)
      end
    end
  end

  describe 'sad path' do
    it 'errors gracefully with bad search', vcr: 'bad_geocode' do
      response = described_class.geocode('Nonexistent')
      expect(response[:results]).to eq([])
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
