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
      [['Beaches', 'beaches'], ['Comedy', 'comedyclubs'], ['Festivals', 'festivals,yelpevents'],
       ['Gardens', 'gardens'], ['Lakes', 'lakes'], ['Landmarks', 'landmarks'],
       ['Markets', 'farmersmarket,fleamarkets'], ['Museums', 'museums'],
       ['Nightlife', 'barcrawl,clubcrawl,danceclubs,musicvenues'], ['Parks', 'parks,hiking'],
       ['Skiing', 'skiing,skiresorts'], ['Spas', 'spas,saunas,massage,hotsprings'],
       ['Tours', 'tours'], ['Zoos', 'zoos,aquariums']]
    end

    def restaurant_data
      [['Bakeries', 'bagels,bakeries,cupcakes,donuts'], ['Barbeque', 'bbq'],
       ['Breweries', 'breweries'], ['Brunch', 'breakfast_brunch'], ['Cafes', 'cafes,coffee'],
       ['Caribbean', 'caribbean'], ['Chinese', 'chinese,dimsum,wok'], ['Italian', 'italian'],
       ['Indian', 'indpak'], ['Japanese', 'japanese,sushi'], ['Mexican', 'mexican'],
       ['Seafood', 'seafood'], ['Steak', 'steak'], ['Vegetarian', 'vegan,vegetarian']]
    end
  end
end
