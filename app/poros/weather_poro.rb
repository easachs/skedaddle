# frozen_string_literal: true

class WeatherPoro
  def initialize(attributes)
    @daily = attributes&.dig(:daily)
  end

  def days
    return [] if @daily.blank?

    @daily[0..6].map do |day|
      { date: Time.zone.at(day[:dt]).strftime('%a'),
        temp: day[:temp][:day],
        description: day[:weather].first[:main] }
    end
  end
end
