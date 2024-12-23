# frozen_string_literal: true

module Core
  class SearchComponent < ViewComponent::Base
    private

    def sort_options
      [['Best match', 'best_match'], ['Rating', 'rating'], ['Distance', 'distance']]
    end

    # def lodging_data
    #   [['B & B', 'bedbreakfast'], ['Campgrounds', 'campgrounds'],
    #    ['Hostel', 'hostels'], ['Resort', 'hotels,resorts']]
    # end

    def activity_data
      [['Beaches', 'beaches,lakes', 'Sand, Sun & Surf'], ['Festivals', 'festivals,yelpevents', 'Bonne fete'],
       ['Landmarks', 'landmarks', 'History, but photogenic'],
       ['Markets', 'farmersmarket,fleamarkets', 'Bargains, Beets, Battlestar Galactica'],
       ['Museums', 'museums', 'Get cultured, not bored'],
       ['Nightlife', 'barcrawl,clubcrawl,comedyclubs,danceclubs,musicvenues', 'Neon nights, city lights'],
       ['Parks', 'parks,gardens', 'Green and Serene'], ['Skiing', 'skiing,skiresorts', 'Send it!'],
       ['Spas', 'spas,saunas,massage,hotsprings', 'Destination Relaxation'],
       ['Tours', 'tours', 'Trail Tales'], ['Zoos', 'zoos,aquariums', 'Creature Comforts']]
    end

    def restaurant_data
      [['African', 'african'], ['Bakeries', 'bagels,bakeries,cupcakes,donuts'], ['Barbeque', 'bbq'],
       ['Breweries', 'breweries'], ['Brunch', 'breakfast_brunch'], ['Cafes', 'cafes,coffee'],
       ['Caribbean', 'caribbean'], ['Chinese', 'chinese,dimsum,wok'],
       ['Italian', 'italian'], ['Indian', 'indpak'], ['Japanese', 'japanese,sushi'], ['Mexican', 'mexican'],
       ['Seafood', 'seafood'], ['Steak', 'steak'], ['Vegetarian', 'vegan,vegetarian']]
    end
  end
end
