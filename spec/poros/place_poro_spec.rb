# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlacePoro do
  attributes = { displayName: { text: 'Denver International Airport' },
                 formattedAddress: '8500 Pena Boulevard',
                 group: 'airport' }

  let(:place) { described_class.new(attributes) }

  it 'exists' do
    expect(place).to be_a(described_class)
  end

  describe 'has attributes' do
    it 'name' do
      expect(place.name).to eq('Denver International Airport')
    end

    it 'address' do
      expect(place.address).to eq('8500 Pena Boulevard')
    end

    it 'group' do
      expect(place.group).to eq('airport')
    end

    it 'serialized' do
      expected = { name: 'Denver International Airport',
                   address: '8500 Pena Boulevard',
                   group: 'airport' }
      expect(place.serialized).to eq(expected)
    end
  end

  describe 'errors gracefully' do
    let(:bad_place) { described_class.new({}) }

    it 'name' do
      expect(bad_place.name).to be_nil
    end

    it 'address' do
      expect(bad_place.address).to be_nil
    end

    it 'group' do
      expect(bad_place.group).to be_nil
    end
  end
end
