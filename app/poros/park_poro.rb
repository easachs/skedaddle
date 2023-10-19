# frozen_string_literal: true

class ParkPoro
  attr_reader :name,
              :location,
              :description,
              :directions,
              :activities,
              :url,
              :thumbnail

  def initialize(attributes)
    @name = attributes[:name]
    @location = format_location(attributes)
    @description = attributes[:description]
    @directions = attributes[:directions]
    @activities = attributes[:activities]&.keys&.join(', ')
    @url = attributes[:activities]&.values&.dig(0, :url)
    @thumbnail = attributes[:activities]&.values&.dig(0, :thumbnail)
  end

  def format_location(attributes)
    return if attributes.blank?

    [attributes[:city],
     (attributes[:state] if attributes[:state] != ('All' || 'Not found')),
     attributes[:country]].compact.join(', ')
  end

  def serialized
    {
      name: @name,
      location: @location,
      description: @description,
      directions: @directions,
      activities: @activities,
      url: @url,
      thumbnail: @thumbnail
    }
  end
end
