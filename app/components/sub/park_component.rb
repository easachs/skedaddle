# frozen_string_literal: true

module Sub
  class ParkComponent < ViewComponent::Base
    attr_reader :park

    def initialize(park:, **options)
      super
      @park    = park
      @options = options
    end

    private

    def saved = @options.fetch(:saved, false)
  end
end
