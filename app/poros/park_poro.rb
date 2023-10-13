# frozen_string_literal: true

class ParkPoro
  attr_reader :name,
              :city,
              :state,
              :country,
              :description,
              :directions,
              :lat,
              :lon,
              :activities,
              :url,
              :thumbnail

  def initialize(attributes)
    @name = attributes[:name]
    @city = attributes[:city]
    @state = attributes[:state]
    @country = attributes[:country]
    @description = attributes[:description]
    @directions = attributes[:directions]
    @lat = attributes[:lat]
    @lon = attributes[:lon]
    @activities = attributes[:activities]&.keys&.join(', ')
    @url = attributes[:activities]&.values&.dig(0, :url)
    @thumbnail = attributes[:activities]&.values&.dig(0, :thumbnail)
  end

  def serialized
    {
      name: @name,
      city: @city,
      state: @state,
      country: @country,
      description: @description,
      directions: @directions,
      lat: @lat,
      lon: @lon,
      activities: @activities,
      url: @url,
      thumbnail: @thumbnail
    }
  end
end
