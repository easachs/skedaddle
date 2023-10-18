# frozen_string_literal: true

class AirportFacade
  def self.airports_near(location)
    airports = AirportService.airports_near(location)
    return if airports[:error] || airports[:airports]&.empty?

    sorted = airports[:airports].select { |air| air[:classification] <= 4 }
                                .sort_by { |air| air[:classification] }
    sorted[0..1].map { |air| AirportPoro.new(air) }
  end
end
