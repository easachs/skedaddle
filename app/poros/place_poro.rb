# frozen_string_literal: true

class PlacePoro
  attr_reader :name, :address, :group

  def initialize(attributes)
    return if attributes.blank?

    @name = attributes&.dig(:displayName, :text)
    @address = attributes&.dig(:formattedAddress)
    @group = attributes&.dig(:group)
  end

  def serialized
    { name:, address:, group: }
  end
end
