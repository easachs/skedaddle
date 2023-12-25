# frozen_string_literal: true

module Sub
  class WeatherComponent < ViewComponent::Base
    attr_reader :weather

    def initialize(weather:)
      super
      @weather = weather
    end
  end
end
