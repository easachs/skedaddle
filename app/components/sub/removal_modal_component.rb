# frozen_string_literal: true

module Sub
  class RemovalModalComponent < ViewComponent::Base
    attr_reader :removal_path, :trigger_class

    def initialize(removal_path:, trigger_class: '')
      @removal_path = removal_path
      @trigger_class = trigger_class
      super
    end
  end
end
