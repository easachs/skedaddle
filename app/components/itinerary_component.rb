# frozen_string_literal: true

class ItineraryComponent < ViewComponent::Base
  attr_reader :id, :label, :parks, :businesses

  def initialize(label:, parks:, businesses:, id: nil, **options)
    @id = id
    @label = label
    @parks = parks
    @businesses = businesses
    @options = options
  end

  private

  def saved
    @options.fetch(:saved, false)
  end
end
