# frozen_string_literal: true

class PlacePoro
  attr_reader :name, :address, :main

  def initialize(attributes)
    return if attributes.blank?

    @main = attributes[:main]

    if attributes[:displayName].present?
      @name = attributes[:displayName][:text]
      @address = attributes[:formattedAddress]
    else
      @name = attributes[:name]
      @address = attributes[:vicinity]
    end
  end

  def serialized
    { name: @name, address: @address, main: @main }
  end
end
