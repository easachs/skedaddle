# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GptService do
  let(:itinerary) do
    Itinerary.create(search: 'Denver, CO, USA',
                     city: 'Denver',
                     lat: 39.740959,
                     lon: -104.985798,
                     start_date: '12/25/2023',
                     end_date: '12/27/2023').decorate
  end

  let(:key) { ENV.fetch('OPENAI_KEY', nil) }
  let(:response) { described_class.plan(itinerary) }

  describe 'gets plan', vcr: 'denver_update' do
    it 'as string' do
      expect(response).to be_a(String)
    end

    it 'formatted for html' do
      expect(response).to include('<p>')
    end

    it 'with days' do
      expect(response).to include('Day 1:')
    end

    it 'with day parts' do
      expect(response).to include('Morning:')
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
