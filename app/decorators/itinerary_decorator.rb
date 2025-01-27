# frozen_string_literal: true

class ItineraryDecorator < Draper::Decorator
  delegate_all

  def prompt
    "Create a #{trip_length || 3} day itinerary for a trip to #{search} incorporating some of the following:
    #{park_list if parks} / #{business_list}. Prioritize these: #{favorited_businesses}.
    Also include other important sites or landmarks that could be worth visiting."
  end

  def trip_length
    return unless start_date && end_date

    days = (Date.strptime(end_date, '%m/%d/%y') - Date.strptime(start_date, '%m/%d/%y')).to_i + 1
    days = [days, 2].max
    [days, 7].min
  end

  def park_list = "Parks - #{parks.pluck(:name).join(', ')}"

  def business_list
    [activities, restaurants].map do |group|
      group.map { |kind, bus| "#{kind} - #{bus.map(&:name).join(', ')}" }.join(' / ')
    end.join(' / ')
  end

  def favorited_businesses = businesses.favorited.pluck(:name).join(', ')
end
