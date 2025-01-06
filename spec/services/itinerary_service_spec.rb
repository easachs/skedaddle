# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItineraryService, vcr: 'denver_search' do
  let(:geocode) { { lat: 39.7392358, lon: -104.990251 } }
  let(:session) do
    { activities: { landmarks: 'landmarks' },
      options: { distance: '15', sort: 'best_match' } }
  end
  let(:service) { described_class }
  let(:items) { described_class.prepare_items(geocode, session) }

  describe 'prepares items' do
    it 'in hash' do
      expect(items).to be_a(Hash)
    end

    describe 'with keys' do
      it 'airports' do
        expect(items.keys).to include(:airports)
      end

      it 'hospitals' do
        expect(items.keys).to include(:hospitals)
      end

      it 'parks' do
        expect(items.keys).to include(:parks)
      end

      it 'activities' do
        expect(items.keys).to include(:activities)
      end

      it 'restaurants' do
        expect(items.keys).to include(:restaurants)
      end
    end

    describe 'with appropriate values for' do
      it 'airports' do
        expect(items[:airports]).to be_all(PlacePoro)
      end

      it 'hospitals' do
        expect(items[:hospitals]).to be_all(PlacePoro)
      end

      it 'parks' do
        expect(items[:parks]).to be_all(ParkPoro)
      end

      it 'activities' do
        expect(items[:activities]).to be_a(Hash)
      end

      it 'restaurants' do
        expect(items[:restaurants]).to be_nil
      end
    end
  end

  describe 'no results check' do
    let(:no_results_check) { described_class.no_results?(items) }

    it 'returns false when there are results' do
      expect(no_results_check).to be_falsey
    end

    it 'returns false when there are no business searches' do
      items[:activities] = nil
      expect(no_results_check).to be_falsey
    end

    it 'returns true when search attempt with no results' do
      items[:activities] = { landmarks: [] }
      expect(no_results_check).to be_truthy
    end
  end

  describe 'formats the date' do
    it 'to m/d/y' do
      date = '2025-01-05'
      expect(service.format_date(date)).to eq('01/05/25')
    end
  end
end
