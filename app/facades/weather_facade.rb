# frozen_string_literal: true

class WeatherFacade
  class << self
    def forecast(location = {})
      return if location.blank?

      weather = WeatherService.forecast(location)
      WeatherPoro.new(weather).days
    end
  end
end
