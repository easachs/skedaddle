# frozen_string_literal: true

module Core
  class DropdownComponent < ViewComponent::Base
    attr_reader :title, :box_class

    def initialize(title: '', box_class: '')
      super
      @title        = title
      @box_class    = box_class
    end
  end
end
