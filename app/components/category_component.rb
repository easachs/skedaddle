# frozen_string_literal: true

class CategoryComponent < ViewComponent::Base
  attr_reader :items, :category

  def initialize(items:, category: '', **options)
    super
    @items = items
    @category = category
    @options = options
  end

  def saved
    @options.fetch(:saved, false)
  end
end
