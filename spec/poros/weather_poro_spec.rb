# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherPoro do
  attributes = { list: [{ dt: 1_736_488_800,
                          main: { temp: 18.36 },
                          weather: [{ main: 'Clouds' }] }],
                 city: { timezone: -25_200 } }
  let(:weather) { described_class.new(attributes) }

  it 'exists' do
    expect(weather).to be_a(described_class)
  end

  describe 'has attributes' do
    it 'days' do
      expected = [{ date: 'Thu',
                    temp: 18.36,
                    description: 'Clouds' }]
      expect(weather.days).to eq(expected)
    end
  end

  describe 'errors gracefully' do
    it 'when attributes are missing keys' do
      bad_data = { list: nil, city: { timezone: nil } }
      bad_weather = described_class.new(bad_data)

      expect(bad_weather.days).to eq([])
    end

    it 'when an error occurs inside the method' do
      allow(weather).to receive(:daily_forecasts).and_raise(StandardError)

      expect(weather.days).to eq([])
    end
  end
end
