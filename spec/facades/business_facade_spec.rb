# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BusinessFacade' do
  it 'returns instances of businesses', vcr: 'denver_businesses' do
    businesses = BusinessFacade.businesses_near({ lat: 39.740959, lon: -104.985798 })
    expect(businesses).to be_a(Array)
    expect(businesses).to be_all(BusinessPoro)
    expect(businesses.length).to eq(3)
  end

  it 'errors gracefully', vcr: 'bad_businesses' do
    businesses = BusinessFacade.businesses_near({ lat: nil, lon: nil })
    expect(businesses).to eq([])
  end
end
