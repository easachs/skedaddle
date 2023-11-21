# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessFacade do
  it 'returns businesses', vcr: 'denver_businesses' do
    businesses = described_class.near({ lat: 39.740959, lon: -104.985798 }, 'bakeries')
    expect(businesses).to be_all(BusinessPoro)
  end

  describe 'sad path' do
    it 'errors gracefully with bad search' do
      businesses = described_class.near('Nonexistent')
      expect(businesses).to be_nil
    end

    it 'errors gracefully with blank search' do
      businesses = described_class.near('')
      expect(businesses).to be_nil
    end

    it 'errors gracefully with nil search' do
      businesses = described_class.near(nil)
      expect(businesses).to be_nil
    end

    it 'errors gracefully with empty search' do
      businesses = described_class.near({})
      expect(businesses).to be_nil
    end
  end
end
