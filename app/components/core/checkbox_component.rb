# frozen_string_literal: true

module Core
  class CheckboxComponent < ViewComponent::Base
    attr_reader :data, :prefix, :size

    def initialize(data:, prefix:, size:)
      super
      @data   = data
      @prefix = prefix
      @size   = size
    end
  end
end
