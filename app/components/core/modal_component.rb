# frozen_string_literal: true

module Core
  class ModalComponent < ViewComponent::Base
    attr_reader :trigger

    def initialize(trigger: '', escape: true)
      @trigger = trigger
      @escape = escape
      super
    end

    private

    def escapable
      "keydown.esc@window->modal#close #{'click->modal#close' if @escape}"
    end
  end
end
