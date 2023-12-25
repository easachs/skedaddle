# frozen_string_literal: true

module HomeHelper
  def lodging_data
    [['B & B', 'bed and breakfast'], ['Campsite', 'campsites'],
     ['Hostel', 'hostels'], ['Hotel', 'hotels'],
     ['Rental', 'rentals'], ['Resort', 'resort']]
  end

  def activity_data
    [['Beaches', 'beaches'], ['Festivals', 'festivals'],
     ['Galleries', 'galleries'], ['Gardens', 'gardens'],
     ['Golf Courses', 'golf'], ['Guided Tours', 'walkingtours'],
     ['Hot Springs', 'hotsprings'], ['Landmarks', 'landmarks'],
     ['Markets', 'farmersmarket'], ['Museums', 'museums'],
     ['Parks', 'parks'], ['Ski Resorts', 'skiresorts'],
     ['Spas', 'spas,saunas'], ['Theme Parks', 'amusementparks'],
     ['Zoos', 'zoos,aquariums']]
  end

  def restaurant_data
    [['Bakeries', 'bakeries'], ['Breweries', 'breweries'],
     ['Brunch', 'brunch'], ['Cafes', 'cafes'],
     ['Chinese', 'chinese'], ['Delis', 'delis'],
     ['Diners', 'diners'], ['Food Trucks', 'foodtrucks'],
     ['Italian', 'italian'], ['Mexican', 'mexican'],
     ['Pizzerias', 'pizza'], ['Seafood', 'seafood'],
     ['Steakhouses', 'steak'], ['Sushi', 'sushi'],
     ['Thai', 'thai']]
  end
end
