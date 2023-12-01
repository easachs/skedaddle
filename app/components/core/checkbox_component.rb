# frozen_string_literal: true

module Core
  class CheckboxComponent < ViewComponent::Base
    def initialize(data:, prefix:, size:)
      super
      @data = data
      @prefix = prefix
      @size = size
    end
  end
end
