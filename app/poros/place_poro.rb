# frozen_string_literal: true

class PlacePoro
  attr_reader :name, :address, :main

  def initialize(attributes)
    return if attributes.blank?

    @name = attributes&.dig(:displayName, :text)
    @address = attributes&.dig(:formattedAddress)
    @main = attributes&.dig(:main)
  end

  def serialized
    { name:, address:, main: }
  end
end
