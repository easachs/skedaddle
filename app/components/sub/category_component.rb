# frozen_string_literal: true

module Sub
  class CategoryComponent < ViewComponent::Base
    attr_reader :items, :category, :saved

    def initialize(items:, category:, saved: false)
      super
      @items = items
      @category = category
      @saved = saved
    end
  end
end
