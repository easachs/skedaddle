# Skedaddle
  * **Skedaddle** is a **Rails** travel itinerary app that creates a custom travel itinerary for a budgeted, eco-friendly weekend for a given location. It is the continued solo exploration of a past group project.

  * This iteration of **Skedaddle** combines the group project's front end and back end service-oriented architecture into a single monolith application.

  * It consumes API endpoints from **Yelp** (restaurants), **TrailAPI** (trails/parks), and **PositionStack** (geocoding).
    
  * This app creates a <i>custom itinerary</i> with three trails and three restaurants based on geodata.

  * This application utilizes a **relational database** to store user and itinerary data.

  * [Google OAuth 2](https://developers.google.com/identity/protocols/oauth2) is used to authenticate and authorize users.

## Pitch
  Skedaddle is a travel/exploration app that creates a custom travel itinerary for a budgeted, eco-friendly weekend (or 3-day weekend) for a given city, address or location. Results can return parks/hiking/restaurant/museum recommendations, as well as cultural information such as books/music/history. Itineraries could include maps/graphs. Other potential directions include adventure tourism, historical tourism, etc.

## End User
  Targeted towards budget/ecotourism travelers, etc. people who want to travel but need help deciding where to go, or just someone interested in learning more about a given place.

## Problem
  This app will be a one stop shop of travel information and create a short recommended itinerary. Could be budget/ecotourism/outdoors/cultural/etc themed. Restaurants recommended by budget, parks/museums/trails/etc could be recommended based on search criteria as well.

## MVP
  A user will be able to register with a username, email and password and login with a username and password (with sad paths) from the homepage. They will have a dashboard with a nav bar (“my itineraries”, “skedaddle/search”, and “logout”). On the user dashboard a user can see their saved itineraries with links to their show pages and to delete them. On the search page a user can search by location and receive a generated weekend itinerary with 3 nearby restaurants and 3 nearby parks/trails, which is added to that user’s itineraries.

## Stretch
  A user can edit an itinerary (selecting what they like, removing unwanted recommendations, adding new restaurants or parks/hikes) and invite other users/friends to view and edit it. They can search for restaurants by budget, distance, and/or rating, or hikes and parks by activities or difficulty. The app could include top books/poetry/movies/music/historical information for a city/country, and COL/pricing info. More pictures and links. Users can randomize a search.

## Big Stretch
  Users can share and vote on which itinerary to use. Maps are incorporated. Itineraries have other sections, such as events, museums, and breweries. A user can change the length of their trip (and so the length of their itinerary). Hotel/flight APIs could be incorporated, or links to AirBnB/booking/SkyScanner websites. OpenAI/ChatGPT itinerary generation could be incorporated.

## Technical Requirements
  * Ruby 3.2.2
  * Rails 7.0.8
  * RSpec
  * TailwindCSS
  * Stimulus
  * Faraday
  * Dotenv
  * Webmock
  * VCR
  * SimpleCov
  * Orderly
  * Capybara
  * Launchy
  * Factory Bot
  * Faker
  * Postman
  * Shoulda-Matchers
   
## Project Files Description
* **app/controllers/dashboard_controller.rb**
    * Welcome page controller that initiates login via **Google OAuth v2**
    * Dashboard controller that creates *user dashboard view* which provides destination search functionality

* **app/controllers/sessions_controller.rb**
    * Sessions controller that checks for *OmniAuth authentication* and creates a new session for user if authentication is successful 
  
* **app/controllers/itineraries_controller.rb**
    * Uses *before_action* to call backend API in order to receive data on trails and restaraunts based on the destination the user has searched for

* **app/models/user.rb**
    * User model that finds or creates a user after successful OAuth authentication for
  
* **app/models/itinerary.rb**
    * Itinerary model which references park and restaraunt objects created from API calls for
  
* **spec**
    * Contains test suite files
    * Contains *fixtures/vcr_cassettes*, a subfolder that contains mocked data used in tests to prevent API endpoint calls every time testing suite is run

## Routes
  | Rails Routes  |  |  |
  | ------------- | ------------- | ------------- |
  | get  | /  | dashboard#home  |
  | get  | /dashboard  | dashboard#dashboard  |
  | get  | /about  | dashboard#about  |
  | get  | /contact  | contact#new  |
  | get  | /itineraries  | itineraries#index  |
  | post  | /itineraries  | itineraries#create  |
  | get  | /itineraries/:id  | itineraries#show  |
  | delete  | /itineraries/:id  | itineraries#destroy  |
  | get  | /auth/:provider/callback  | sessions#omniauth  |
  | delete  | /sessions  | sessions#destroy  |

## Endpoints

### [TRAILAPI](https://rapidapi.com/trailapi/api/trailapi/)
* Example query:

  `https://trailapi-trailapi.p.rapidapi.com/activity/?q-country_cont=&q-city_cont=Denver`

* Authorization: X-RapidAPI-Key HEADER
* Params: q-activities_activity_type_name_eq (search activities), lat, lon, limit, country_cont (search country), state_cont (search state), radius (from lat/lon), q-city_cont (city search)

### [YELP BUSINESS](https://www.yelp.com/developers/documentation/v3/business_search)
* Example query:

  `https://api.yelp.com/v3/businesses/search?term=restaurants&location=Denver&sort_by=distance`

* Authorization: bearer token
* Params: term, location, latitude, longitude, radius, categories, limit, sort_by (rating/distance), price (1 = $, 2 = $$, etc)

### [POSITIONSTACK](https://positionstack.com/documentation)
* Example query:

  `http://api.positionstack.com/v1/forward?query=Denver`

* Authorization: access_key
* Params: query

## Getting Started

  1. Clone the repository:

    $ git clone git@github.com:easachs/skedaddle.git

  2. Open the repository in your preferred editor.

  3. Install dependencies:

    $ bundle install

  4. Run migrations:

    $ rails db:{create,migrate,seed}

  5. Run the application locally:

    $ bin/dev

  6. Visit localhost:3000.

  ## Testing
    $ bundle exec rspec