# frozen_string_literal: true

class AirportPoro
  attr_reader :name, :address1, :address2

  def initialize(attributes)
    return if attributes.blank?

    @name = "#{attributes[:name]} (#{attributes[:iata]})"
    @address1 = attributes[:street1]
    @address2 = format_location(attributes)
  end

  def format_location(attributes)
    [attributes[:city],
     (attributes[:stateCode] if attributes[:countryCode] == 'US'),
     attributes[:countryCode]].compact.join(', ')
  end

  def serialized
    { name: @name, address1: @address1, address2: @address2 }
  end
end
