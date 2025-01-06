# frozen_string_literal: true

module Sub
  class LoadingModalComponent < ViewComponent::Base
    attr_reader :trigger

    def initialize(trigger: '')
      @trigger = trigger
      super
    end
  end
end
