# frozen_string_literal: true

module Core
  class DropdownComponent < ViewComponent::Base
    attr_reader :title, :title_class, :box_class

    def initialize(title: '', title_class: '', box_class: '')
      super
      @title        = title
      @title_class  = title_class
      @box_class    = box_class
    end
  end
end
