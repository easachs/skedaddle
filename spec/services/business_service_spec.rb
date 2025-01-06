# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessService do
  describe 'gets businesses', vcr: 'denver_search' do
    let(:response) do
      described_class.near(geocode: { lat: 39.7392358, lon: -104.990251 },
                           kind: 'bagels,bakeries,cupcakes,donuts')
    end

    it 'as hash with businesses array' do
      expect(response[:businesses]).to be_a(Array)
    end

    describe 'with keys' do
      it 'name' do
        expect(response[:businesses]).to all(have_key(:name))
      end

      it 'rating' do
        expect(response[:businesses]).to all(have_key(:rating))
      end

      it 'categories' do
        expect(response[:businesses]).to all(have_key(:categories))
      end

      it 'location' do
        expect(response[:businesses]).to all(have_key(:location))
      end

      it 'display_phone' do
        expect(response[:businesses]).to all(have_key(:display_phone))
      end

      it 'url' do
        expect(response[:businesses]).to all(have_key(:url))
      end

      it 'image_url' do
        expect(response[:businesses]).to all(have_key(:image_url))
      end
    end
  end

  describe 'sad path' do
    it 'errors gracefully with empty search' do
      response = described_class.near
      expect(response).to be_nil
    end
  end
end
