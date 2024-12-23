# frozen_string_literal: true

module Core
  class ModalComponent < ViewComponent::Base
    attr_reader :trigger

    def initialize(trigger: '')
      @trigger = trigger
      super
    end
  end
end
