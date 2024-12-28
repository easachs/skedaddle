# frozen_string_literal: true

class WeatherPoro
  def initialize(attributes)
    @attributes = attributes
  end

  def days
    return [] unless @attributes&.dig(:list) && @attributes.dig(:city, :timezone)

    timezone_offset = @attributes[:city][:timezone] || 0
    daily_forecasts.map do |day|
      { date: Time.zone.at(day[:dt] + timezone_offset).strftime('%a'),
        temp: day.dig(:main, :temp),
        description: day.dig(:weather, 0, :main) }
    end
  rescue StandardError
    []
  end

  private

  def daily_forecasts = @attributes[:list].each_slice(8).map(&:first)[0..4]
end
