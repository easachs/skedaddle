# frozen_string_literal: true

class PlacesPoro
  attr_reader :name, :address

  def initialize(attributes)
    return if attributes.blank?

    @name = attributes[:displayName][:text]
    @address = attributes[:formattedAddress]
  end

  def serialized
    { name: @name, address: @address }
  end
end
