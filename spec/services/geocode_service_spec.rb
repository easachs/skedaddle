# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodeService do
  it 'gets lat/lon', vcr: 'denver_geocode' do
    response = described_class.geocode('Denver')
    response[:data].each do |location|
      expect(location).to have_key(:latitude)
      expect(location).to have_key(:longitude)
      expect(location).to have_key(:type)
      expect(location).to have_key(:label)
    end
  end

  it 'can sad path', vcr: 'bad_geocode' do
    response = described_class.geocode('Nonexistent')
    expect(response).to eq({ data: [] })
  end
end
