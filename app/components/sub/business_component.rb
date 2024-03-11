# frozen_string_literal: true

module Sub
  class BusinessComponent < ViewComponent::Base
    attr_reader :business

    def initialize(business:, **options)
      super
      @business = business
      @options  = options
    end

    private

    def saved = @options.fetch(:saved, false)
  end
end
