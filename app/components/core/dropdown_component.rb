# frozen_string_literal: true

module Core
  class DropdownComponent < ViewComponent::Base
    attr_reader :title, :class_list

    def initialize(title = '', class_list = '')
      super
      @title = title
      @class_list = class_list
    end
  end
end
