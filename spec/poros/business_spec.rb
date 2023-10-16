# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessPoro do
  before do
    @attributes = {
      "id": 'eCkWoMKHh5PoNqYvdyviRA',
      "alias": 'spinellis-market-denver-3',
      "name": "Spinelli's Market",
      "image_url": 'https://s3-media4.fl.yelpcdn.com/bphoto/I41o6sGOiWJwgO5yxxQFwg/o.jpg',
      "is_closed": false,
      "url": 'https://www.yelp.com/biz/spinellis-market-denver-3?adjust_creative=3gRykLgv5-_vxngoRlAFrQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=3gRykLgv5-_vxngoRlAFrQ',
      "review_count": 246,
      "categories": [
        {
          "alias": 'delis',
          "title": 'Delis'
        },
        {
          "alias": 'gourmet',
          "title": 'Specialty Food'
        },
        {
          "alias": 'grocery',
          "title": 'Grocery'
        }
      ],
      "rating": 4.5,
      "coordinates": {
        "latitude": 39.751168,
        "longitude": -104.933227
      },
      "transactions": [
        'pickup'
      ],
      "price": '$$',
      "location": {
        "address1": '4621 E 23rd Ave',
        "address2": '',
        "address3": nil,
        "city": 'Denver',
        "zip_code": '80207',
        "country": 'US',
        "state": 'CO',
        "display_address": [
          '4621 E 23rd Ave',
          'Denver, CO 80207'
        ]
      },
      "phone": '+13033298143',
      "display_phone": '(303) 329-8143',
      "distance": 101.23958944836664
    }

    @business = described_class.new(@attributes)
  end

  it 'exists' do
    expect(@business).to be_a(described_class)
  end

  it 'has attributes' do
    expect(@business.name).to eq("Spinelli's Market")
    expect(@business.rating).to eq(4.5)
    expect(@business.price).to eq('$$')
    expect(@business.thumbnail).to eq('https://s3-media4.fl.yelpcdn.com/bphoto/I41o6sGOiWJwgO5yxxQFwg/o.jpg')
    expect(@business.url).to include('https://www.yelp.com/biz/spinellis-market-denver')
    expect(@business.categories).to eq('Delis, Specialty Food, Grocery')
    expect(@business.address).to eq('4621 E 23rd Ave, Denver, CO 80207')
    expect(@business.phone).to eq('(303) 329-8143')
  end

  it 'errors gracefully' do
    bad_business = described_class.new({})
    expect(bad_business.name).to be_nil
    expect(bad_business.rating).to be_nil
    expect(bad_business.price).to be_nil
    expect(bad_business.thumbnail).to be_nil
    expect(bad_business.url).to be_nil
    expect(bad_business.categories).to be_nil
    expect(bad_business.address).to be_nil
    expect(bad_business.phone).to be_nil
  end
end
