# frozen_string_literal: true

class ItineraryComponent < ViewComponent::Base
  attr_reader :search, :city, :items

  def initialize(search:, city:, items:, **options)
    super
    @search = search
    @city = city
    @items = items
    @options = options
  end

  private

  def id
    @options.fetch(:id, nil)
  end

  def saved
    @options.fetch(:saved, false)
  end

  def airports
    @items[:airports]
  end

  def parks
    @items[:parks]
  end

  def activities
    @items[:activities]
  end

  def restaurants
    @items[:restaurants]
  end
end
