# frozen_string_literal: true

class ItineraryComponent < ViewComponent::Base
  attr_reader :id, :label, :locality, :parks, :businesses

  def initialize(label:, locality:, parks:, businesses:, id: nil, **options)
    @id = id
    @label = label
    @locality = locality
    @parks = parks
    @businesses = businesses
    @options = options
  end

  private

  def saved
    @options.fetch(:saved, false)
  end
end
