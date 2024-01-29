# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessFacade do
  it 'returns businesses', vcr: 'denver_businesses' do
    businesses = described_class.near(geo: { lat: 39.740959, lon: -104.985798 }, kind: 'bakeries')
    expect(businesses).to be_all(BusinessPoro)
  end

  describe 'sad path' do
    it 'errors gracefully with empty search' do
      businesses = described_class.near
      expect(businesses).to be_nil
    end
  end
end
