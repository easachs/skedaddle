# frozen_string_literal: true

class AirportFacade
  def self.airports_near(location)
    return if location.blank?

    airports = AirportService.airports_near(location)
    return if airports[:error] || airports[:airports]&.empty?

    refine(airports).map { |air| AirportPoro.new(air) }
  end

  def self.refine(airports)
    airports[:airports].select { |air| air[:classification] <= 4 }
                       .sort_by { |air| air[:classification] }[0..1]
  end
end
