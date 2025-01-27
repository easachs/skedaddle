# frozen_string_literal: true

module Sub
  class CategoryComponent < ViewComponent::Base
    attr_reader :items, :category

    def initialize(items:, category:, **options)
      super
      @items    = items
      @category = category
      @options  = options
    end

    private

    def saved = @options.fetch(:saved, false)
  end
end
