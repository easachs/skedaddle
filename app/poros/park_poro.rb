# frozen_string_literal: true

class ParkPoro
  attr_reader :name, :location, :description, :directions

  def initialize(attributes)
    return unless attributes.is_a?(Hash)

    @name         = attributes&.dig(:name)
    @location     = format_location(attributes)
    @description  = sanitize(attributes&.dig(:description))
    @directions   = sanitize(attributes&.dig(:directions))
    @object       = attributes&.dig(:activities)
  end

  def format_location(attributes)
    return if attributes.blank?

    [attributes[:city], attributes[:state], attributes[:country]]
      .reject { |attr| attr.blank? || attr == 'All' || attr == 'Not found' }
      .join(', ')
  end

  def sanitize(string)
    ActionView::Base.full_sanitizer.sanitize(string)
  end

  def activities  = @object&.keys&.join(', ')
  def url         = @object&.values&.dig(0, :url)
  def thumbnail   = @object&.values&.dig(0, :thumbnail)

  def serialized
    { name:, location:, description:, directions:,
      activities:, url:, thumbnail: }
  end
end
