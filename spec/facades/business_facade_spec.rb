# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessFacade do
  it 'returns businesses', vcr: 'denver_search' do
    businesses = described_class.near(geocode: { lat: 39.7392358, lon: -104.990251 },
                                      kind: 'bagels,bakeries,cupcakes,donuts')
    expect(businesses).to be_all(BusinessPoro)
  end

  describe 'sad path' do
    it 'errors gracefully with empty search' do
      businesses = described_class.near
      expect(businesses).to be_nil
    end
  end
end
