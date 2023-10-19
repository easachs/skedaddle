# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParkPoro do
  attributes = {
    name: 'Green Mountain',
    city: 'Denver',
    state: 'Colorado',
    country: 'United States',
    description: 'This park has three parking areas. The loop is the same from all.',
    directions: 'From I-25, take 6th Ave. west. Drive approximately 6 miles to Kipling.',
    lat: '39.6967',
    lon: '-105.1922',
    parent_id: '0',
    place_id: '694',
    activities: {
      'mountain biking': {
        url: 'http://www.singletracks.com/item.php?c=1&i=14',
        length: '7',
        description: 'This park has three parking areas. The loop is the same from all.',
        name: 'Green Mountain',
        rank: '0',
        rating: '3.32',
        thumbnail: 'http://images.singletracks.com/2009/trails/01/14-1180981080.jpg',
        activity_type: '5',
        activity_type_name: 'mountain biking',
        attribs: {
          length: '7',
          nightride: '1'
        },
        place_activity_id: '936404'
      },
      hiking: {
        url: 'http://www.tripleblaze.com/trail.php?c=3&i=275',
        length: '7',
        description: 'With more than 2,400 acres of open space, William Frederick Hayden Park on Green Mountain is',
        name: 'Green Mountain--William Frederick Hayden Park',
        rank: '0',
        rating: '0.00',
        thumbnail: 'http://images.tripleblaze.com/2009/02/275-1223987631.jpg',
        activity_type: '2',
        activity_type_name: 'hiking',
        attribs: {
          length: '7'
        },
        place_activity_id: '945866'
      }
    }
  }

  let(:park) { described_class.new(attributes) }

  it 'exists' do
    expect(park).to be_a(described_class)
  end

  describe 'has attributes' do
    it 'name' do
      expect(park.name).to eq('Green Mountain')
    end

    it 'location' do
      expect(park.location).to eq('Denver, Colorado, United States')
    end

    it 'description' do
      expect(park.description).to include('This park has three parking areas')
    end

    it 'directions' do
      expect(park.directions).to include('From I-25, take 6th Ave')
    end

    it 'activities' do
      expect(park.activities).to eq('mountain biking, hiking')
    end

    it 'url' do
      expect(park.url).to eq('http://www.singletracks.com/item.php?c=1&i=14')
    end

    it 'thumbnail' do
      expect(park.thumbnail).to eq('http://images.singletracks.com/2009/trails/01/14-1180981080.jpg')
    end
  end

  describe 'errors gracefully' do
    let(:bad_park) { described_class.new({}) }

    it 'name' do
      expect(bad_park.name).to be_nil
    end

    it 'location' do
      expect(bad_park.location).to be_nil
    end

    it 'description' do
      expect(bad_park.description).to be_nil
    end

    it 'directions' do
      expect(bad_park.directions).to be_nil
    end

    it 'activities' do
      expect(bad_park.activities).to be_nil
    end

    it 'url' do
      expect(bad_park.url).to be_nil
    end

    it 'thumbnail' do
      expect(bad_park.thumbnail).to be_nil
    end
  end
end
