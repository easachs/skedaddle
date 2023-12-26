# frozen_string_literal: true

# == Schema Information
#
# Table name: itineraries
#
#  id         :bigint           not null, primary key
#  search     :string
#  city       :string
#  region     :string
#  country    :string
#  lat        :float
#  lon        :float
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Itinerary < ApplicationRecord
  validates :search, :city, :lat, :lon, presence: true
  belongs_to :user
  has_many :places, dependent: :destroy
  has_many :parks, dependent: :destroy
  has_many :businesses, dependent: :destroy
  has_one :summary, dependent: :destroy

  def date        = created_at.strftime('%m/%d/%y')
  def coordinates = { lat:, lon: }

  def airports    = places.where(group: 'airport')
  def hospitals   = places.where(group: 'hospital')
  def activities  = businesses.where(group: 'activities').group_by(&:kind)
  def restaurants = businesses.where(group: 'restaurants').group_by(&:kind)

  def items       = { airports:, hospitals:, parks:, activities:, restaurants: }

  # Prompt for GPT
  def prompt
    "Create a 3 day itinerary for #{search} incorporating some of the following.
    #{park_list} / #{business_list}
    Also include other important sites or landmarks that could be worth visiting."
  end

  private

  def park_list
    "Parks - #{parks.pluck(:name).join(', ')}"
  end

  # def business_list
  #   [activities, restaurants].map do |group|
  #     array = group.map { |k, v| { k => v.map(&:name).join(', ') } }
  #     array.map { |a| a.map { |k, v| "#{k} - #{v}" } }.join(' / ')
  #   end.join(' / ')
  # end

  def business_list
    [activities, restaurants].map do |group|
      group.map { |k, v| "#{k} - #{v.map(&:name).join(', ')}" }.join(' / ')
    end.join(' / ')
  end
end
