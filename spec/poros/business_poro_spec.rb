# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessPoro do
  attributes = {
    id: 'eCkWoMKHh5PoNqYvdyviRA',
    alias: 'spinellis-market-denver-3',
    name: "Spinelli's Market",
    image_url: 'https://s3-media4.fl.yelpcdn.com/bphoto/I41o6sGOiWJwgO5yxxQFwg/o.jpg',
    is_closed: false,
    url: 'https://www.yelp.com/biz/spinellis-market-denver-3?adjust_creative=3gRykLgv5-_vxngoRlAFrQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=3gRykLgv5-_vxngoRlAFrQ',
    review_count: 246,
    categories: [
      {
        alias: 'delis',
        title: 'Delis'
      },
      {
        alias: 'gourmet',
        title: 'Specialty Food'
      },
      {
        alias: 'grocery',
        title: 'Grocery'
      }
    ],
    rating: 4.5,
    coordinates: {
      latitude: 39.751168,
      longitude: -104.933227
    },
    transactions: [
      'pickup'
    ],
    price: '$$',
    location: {
      address1: '4621 E 23rd Ave',
      address2: '',
      address3: nil,
      city: 'Denver',
      zip_code: '80207',
      country: 'US',
      state: 'CO',
      display_address: [
        '4621 E 23rd Ave',
        'Denver, CO 80207'
      ]
    },
    phone: '+13033298143',
    display_phone: '(303) 329-8143',
    distance: 101.23958944836664
  }

  let(:business) { described_class.new(attributes) }

  it 'exists' do
    expect(business).to be_a(described_class)
  end

  describe 'has attributes' do
    it 'name' do
      expect(business.name).to eq("Spinelli's Market")
    end

    it 'rating' do
      expect(business.rating).to eq(4.5)
    end

    it 'price' do
      expect(business.price).to eq('$$')
    end

    it 'categories' do
      expect(business.categories).to eq('Delis, Specialty Food, Grocery')
    end

    it 'location' do
      expect(business.location).to eq('4621 E 23rd Ave, Denver, CO 80207')
    end

    it 'phone' do
      expect(business.phone).to eq('(303) 329-8143')
    end

    it 'url' do
      expect(business.url).to include('https://www.yelp.com/biz/spinellis-market-denver')
    end

    it 'thumbnail' do
      expect(business.thumbnail).to eq('https://s3-media4.fl.yelpcdn.com/bphoto/I41o6sGOiWJwgO5yxxQFwg/o.jpg')
    end

    it 'serialized' do
      expected = { name: "Spinelli's Market", rating: 4.5, price: '$$',
                   categories: 'Delis, Specialty Food, Grocery', location: '4621 E 23rd Ave, Denver, CO 80207',
                   phone: '(303) 329-8143', url: business.url,
                   thumbnail: 'https://s3-media4.fl.yelpcdn.com/bphoto/I41o6sGOiWJwgO5yxxQFwg/o.jpg' }
      expect(business.serialized).to eq(expected)
    end
  end

  describe 'errors gracefully' do
    let(:bad_business) { described_class.new({}) }

    it 'name' do
      expect(bad_business.name).to be_nil
    end

    it 'rating' do
      expect(bad_business.rating).to be_nil
    end

    it 'price' do
      expect(bad_business.price).to be_nil
    end

    it 'categories' do
      expect(bad_business.categories).to be_nil
    end

    it 'location' do
      expect(bad_business.location).to be_nil
    end

    it 'phone' do
      expect(bad_business.phone).to be_nil
    end

    it 'url' do
      expect(bad_business.url).to be_nil
    end

    it 'thumbnail' do
      expect(bad_business.thumbnail).to be_nil
    end
  end
end
