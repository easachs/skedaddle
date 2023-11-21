# frozen_string_literal: true

class PlacePoro
  attr_reader :name, :address, :main

  def initialize(attributes)
    return if attributes.blank?

    @name = attributes[:displayName][:text]
    @address = attributes[:formattedAddress]
    @main = attributes[:main]
  end

  def serialized
    { name: @name, address: @address, main: @main }
  end
end
