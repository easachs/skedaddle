# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessService do
  it 'gets businesses', vcr: 'denver_businesses' do
    response = described_class.businesses_near({ lat: 39.740959, lon: -104.985798 })
    expect(response).to be_a(Hash)
    expect(response.length).to eq(3)
    expect(response[:businesses]).to be_a(Array)
    response[:businesses].each do |business|
      expect(business).to have_key(:name)
      expect(business).to have_key(:rating)
      expect(business).to have_key(:image_url)
      expect(business).to have_key(:url)
      expect(business).to have_key(:categories)
      expect(business).to have_key(:location)
      expect(business).to have_key(:display_phone)
    end
  end

  it 'can sad path', vcr: 'bad_businesses' do
    response = described_class.businesses_near({ lat: nil, lon: nil })
    expect(response).to eq({
                             error: {
                               code: 'VALIDATION_ERROR',
                               description: 'Please specify a location or a latitude and longitude'
                             }
                           })
  end
end
