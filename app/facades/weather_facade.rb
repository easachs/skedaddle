# frozen_string_literal: true

class WeatherFacade
  class << self
    def forecast(location = {})
      return if location.blank? || !location.is_a?(Hash)

      weather = WeatherService.forecast(location)
      WeatherPoro.new(weather).days
    end
  end
end
