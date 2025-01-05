# frozen_string_literal: true

module Sub
  class RemovalModalComponent < ViewComponent::Base
    attr_reader :removal_path, :trigger_text, :trigger_class, :turbo

    def initialize(removal_path:, trigger_text: '✖', trigger_class: '', turbo: true)
      @removal_path = removal_path
      @trigger_text = trigger_text
      @trigger_class = trigger_class
      @turbo = turbo
      super
    end
  end
end
