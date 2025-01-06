# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GptService, vcr: 'denver_search' do
  let(:itinerary) do
    Itinerary.create(search: 'Denver, CO, USA',
                     city: 'Denver',
                     lat: 39.7392358,
                     lon: -104.990251,
                     start_date: '12/25/2023',
                     end_date: '12/27/2023').decorate
  end

  let(:info_response) { described_class.info(itinerary) }
  let(:plan_response) { described_class.plan(itinerary) }

  describe 'gets info' do
    it 'as string' do
      expect(info_response).to be_a(String)
    end

    it 'formatted for html' do
      expect(info_response).to include('<p>')
    end

    it 'with headings' do
      expect(info_response).to include('<h3>History</h3>')
    end
  end

  describe 'sad path' do
    describe 'with bad itinerary' do
      it 'errors gracefully' do
        response = described_class.plan(nil)
        expect(response).to be_nil
      end
    end

    describe 'with bad prompt' do
      it 'errors gracefully' do
        allow(itinerary).to receive(:prompt).and_return(nil)
        response = described_class.plan(itinerary)
        expect(response).to be_nil
      end
    end
  end
end
