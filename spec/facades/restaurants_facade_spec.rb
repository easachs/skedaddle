# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RestaurantFacade' do
  it 'returns instances of restaurants', vcr: 'denver_restaurants' do
    restaurants = RestaurantFacade.restaurants_near({ lat: 39.740959, lon: -104.985798 })
    expect(restaurants).to be_a(Array)
    expect(restaurants).to be_all(RestaurantPoro)
    expect(restaurants.length).to eq(3)
  end

  it 'errors gracefully', vcr: 'bad_restaurants' do
    restaurants = RestaurantFacade.restaurants_near({ lat: nil, lon: nil })
    expect(restaurants).to eq([])
  end
end
