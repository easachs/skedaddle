# frozen_string_literal: true

class HospitalComponent < ViewComponent::Base
  attr_reader :hospital

  def initialize(hospital:)
    super
    @hospital = hospital
  end
end
