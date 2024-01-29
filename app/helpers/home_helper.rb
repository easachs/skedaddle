# frozen_string_literal: true

module HomeHelper
  def count_options = (1..5).to_a.map { |n| [n, n] }

  def sort_options
    [['Best match', 'best'],
     ['Rating', 'rating'],
     ['Distance', 'distance']]
  end

  # def lodging_data
  #   [['B & B', 'bed and breakfast'], ['Campsite', 'campsites'],
  #    ['Hostel', 'hostels'], ['Resort', 'hotels,resort']]
  # end

  def activity_data
    [['Beaches', 'beaches'], ['Festivals', 'festivals'],
     ['Galleries', 'galleries'], ['Hot Springs', 'hotsprings'],
     ['Landmarks', 'landmarks'], ['Markets', 'farmersmarket'],
     ['Museums', 'museums'], ['Parks', 'parks'],
     ['Skiing', 'skiresorts'], ['Spas', 'spas,saunas'],
     ['Tours', 'walkingtours'], ['Zoos', 'zoos,aquariums']]
  end

  def restaurant_data
    [['Bakeries', 'bakeries'], ['Breweries', 'breweries'],
     ['Brunch', 'brunch'], ['Cafes', 'cafes'],
     ['Diners', 'diners'], ['Food Trucks', 'foodtrucks'],
     ['Italian', 'italian'], ['Mexican', 'mexican'],
     ['Pizza', 'pizza'], ['Seafood', 'seafood'],
     ['Steakhouses', 'steak'], ['Sushi', 'sushi']]
  end
end
