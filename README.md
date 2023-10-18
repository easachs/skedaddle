# Skedaddle
  * **Skedaddle** is a **Rails** travel app that creates a custom itinerary for a given location. It is the continued solo exploration of a past group project.

  * This iteration of **Skedaddle** combines the group project's front end and back end service-oriented architecture into a single monolith application.

  * It consumes API endpoints from **Yelp** (businesses), **TrailAPI** (trails/parks), and **PositionStack** (geocoding).
    
  * This app creates a **custom itinerary** with three trails and three restaurants based on geodata.

  * This application utilizes a **relational database** to store user and itinerary data.

  * [Google OAuth 2](https://developers.google.com/identity/protocols/oauth2) is used to authenticate and authorize users.

## Pitch
  Skedaddle is a travel/exploration app that creates a custom travel itinerary for a given city, address or location. Results can return parks/hiking/restaurant/museum recommendations, as well as cultural information such as books/music/history. Itineraries could include maps/graphs. Other potential directions include adventure tourism, historical tourism, etc.

## End User
  Targeted towards people who want to travel but need help deciding where to go, or just someone interested in learning more about a given place.

## Problem
  This app will be a one stop shop of travel information and generate a short recommended itinerary. Could be budget/ecotourism/outdoors/cultural/etc themed. Businesses recommended by budget, parks/museums/trails/etc could be recommended based on search criteria as well.

## MVP
  A user will be able to register and login from the homepage. They will have a dashboard with a nav bar ("Skedaddle", “Itineraries”, and “Log Out”). On the dashboard a user can see their saved itineraries with links to their show pages and to delete them. On the search page a user can search by location and receive a generated itinerary with nearby businesses and parks/trails, which is added to that user’s itineraries.

## Stretch
  A user can edit an itinerary (selecting what they like, removing unwanted recommendations, adding new restaurants or parks/hikes) and invite other users/friends to view and edit it. They can search for restaurants by budget, distance, and/or rating, or hikes and parks by activities or difficulty. The app could include top books/poetry/movies/music/historical information for a city/country, and COL/pricing info. More pictures and links.

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
  * Factory Bot
  * Faker
  * Shoulda-Matchers
   
## Project Files Description
* **app/controllers/home_controller.rb**
    * Welcome page controller that initiates login via **Google OAuth v2**
    * Dashboard controller that creates *user dashboard* which provides search functionality

* **app/controllers/sessions_controller.rb**
    * Checks for *OmniAuth authentication* and creates a new session if authentication is successful 
  
* **app/controllers/itineraries_controller.rb**
    * Uses *before_action* to call backend API in order to receive data on trails and restaraunts

* **app/models/user.rb**
    * User model that finds or creates a user after successful OAuth authentication
  
* **app/models/itinerary.rb**
    * Itinerary model which references park and restaraunt objects created from API calls
  
* **spec**
    * Contains *fixtures/vcr_cassettes* with mocked data used in tests

## Routes
  | Rails Routes  |  |  |
  | ------------- | ------------- | ------------- |
  | get  | /  | home#home  |
  | get  | /about  | home#about  |
  | get  | /contact  | contact#new  |
  | post  | /contact  | contact#create  |
  | get  | /itineraries  | itineraries#index  |
  | get  | /itineraries/new  | itineraries#new  |
  | post  | /itineraries  | itineraries#create  |
  | get  | /itineraries/:id  | itineraries#show  |
  | delete  | /itineraries/:id  | itineraries#destroy  |
  | delete  | /parks/:id  | parks#destroy  |
  | delete  | /businesses/:id  | businesses#destroy  |
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