# Skedaddle

## What is **Skedaddle**?
  * **Skedaddle** is a **Rails** travel app that creates a custom itinerary for a given location. It is the continued solo exploration of a group project.

  * This iteration of **Skedaddle** combines the Mod 3 group project's front and back end service-oriented architecture into a Rails 7 monolith using PostgreSQL, TailwindCSS, and Hotwire.

  * It consumes API endpoints from **Google** (geocoding, airports and hospitals), **Yelp** (activities and restaurants), **TrailAPI** (trails and parks), **OpenWeather** (forecast), and **OpenAI** (itinerary info and plan).

  * [Google OAuth 2](https://developers.google.com/identity/protocols/oauth2) is used to authenticate and authorize users.

## Home
  ![home](https://github.com/easachs/skedaddle/assets/100792434/9fbdeac2-caab-4e25-bd91-c7606804096e)

## Search

  ![search](https://github.com/easachs/skedaddle/assets/100792434/97d00dff-1618-4c35-8a38-ffb9f878e1fe)

## Itinerary

  ![barna](https://github.com/easachs/skedaddle/assets/100792434/e4042da8-26cb-4de9-b621-edd232ee559d)

## Pitch
  Skedaddle is a travel/exploration app that creates a custom travel itinerary for a given city, address or location. It will be a one stop shop of travel information with ecotourism, historical, outdoors, cultural themes, etc. Businesses could be recommended by various criteria such as budget, distance, rating, etc. Results can return recommendations for parks, hiking, restaurant, museum, etc, as well as cultural information such as literature, music and history.

## End User
  This app is targeted towards people who want to travel but need help deciding where to go and what to do, or anyone interested in learning more about a certain place.

## MVP
  A user will be able to register and login from the homepage. They will have a dashboard with a nav bar ("Skedaddle", “Itineraries”, and “Log Out”). On the dashboard a user can see their saved itineraries with links to their show pages and to delete them. On the search page a user can search by location and receive a generated itinerary with nearby businesses and parks/trails, which is added to that user’s itineraries.

## Stretch
  A user can edit an itinerary (selecting what they like, removing unwanted recommendations, adding new restaurants or parks/hikes) and invite other users to view and edit it. They can search for restaurants by budget, distance, and/or rating, or hikes and parks by activities or difficulty. The app could include top books, poetry, movies, music, historical information, and COL/pricing info. There could be more pictures and links on the itinerary.

## Big Stretch
  Users can share and vote on which itinerary to use. Maps are incorporated. Itineraries have other sections, such as events, museums, and breweries. A user can change the length of their trip (and so the length of their itinerary). Hotel and flight APIs could be incorporated, or links to AirBnB / booking / SkyScanner websites. ChatGPT itinerary generation could be incorporated.

## Gemfile
  | Main | | | |
  | - | - | - | - |
  | Ruby 3.2.2 | Rails 7.0.8 | PostgreSQL | View Components |
  | TailwindCSS | Stimulus | Turbo | Devise |
  | OmniAuth | Faraday | Kaminari | Draper |
  | Packwerk | Sentry

  | Dev | | | |
  | - | - | - | - |
  | Rubocop | ERB Lint | Better Errors | Letter Opener |
  | Dotenv | Annotate | Brakeman | Pry

  | Test | | | |
  | - | - | - | - |
  | RSpec | SimpleCov | Capybara | Shouldamatchers |
  | Faker | Webmock | VCR | Factory Bot |
  | Launchy | Orderly |

## Files
### Controllers
* **Home**
    * Welcome page controller that initiates login via **Google OAuth**
    * Dashboard controller that creates *user dashboard* which provides search functionality

* **Itineraries**
    * Calls geocode API in order to retrieve data on places, parks and businesses by lat/lon
    * Creates sessions to pass data from search to prepare to new to create
    * Itinerary creation pipeline logic to find itinerary items via facades, then populate the itinerary by creating records of places, parks, and businesses

* **Contact**
    * Handles mailer for contact form

* **Businesses/Parks**
    * Delete select businesses and parks from a given itinerary

* **Users/OmniAuth**
    * Checks for *OmniAuth authentication* and creates a new session if authentication is successful

* **Errors**
    * Handles 404/500 errors

* **Devise**
    * Handle user registrations, sessions, updates, and lost passwords

### Models
* **User**
    * User model with name, email and password that can find or create a user via OAuth authentication, Devise registerable, authenticable, rememberable, validatable, and omniauthable incorporated

* **Itinerary**
    * Itinerary model with many places, parks and businesses created from API calls
    * Scopes businesses into activities and restaurants
    * Scopes places into airports and hospitals

* **Place/Park/Business**
    * Used to populate the itinerary with hospitals, airports, parks, activities and restaurants

* **Summary**
    * Added to an itinerary when requested and the user has sufficient credits

### Components
* **Core**
    * Carousel: formatting for pages with photo carousel and carousel logic
    * Checkbox: creates checkbox sections using type, size, and data representing different Yelp API business searches
    * Dashboard: layout for dashboard at top of page, logic for signed in/out
    * Dropdown: sandwich button toggles display of a section of the search, itinerary, etc
    * Itinerary: formatting for itinerary layout with sub-components, separates businesses by activities/restaurants, logic for saved itineraries
    * Search: all the logic for the search form used to customize params for an itinerary

* **Sub**
    * Business: formatting for business information
    * Category: groups businesses by category within itinerary
    * Park: formatting for park information
    * Place: formatting for airports and hospitals
    * Weather: formatting for the itinerary forecast

### Stimulus Controllers
* **Address**
    * Logic for connecting Google Places Autocomplete to itinerary search field

* **Carousel**
    * Controller for rotating photo carousel, changes every five seconds or upon clicking, persists across turbo

* **Date**
    * Changes earliest possible itinerary end date depending on start date

* **Dropdown**
    * Handles hiding and displaying dashboard dropdown element

* **Error**
    * Errors disappear from dashboard display after three seconds

* **Slider**
    * Handles showing and changing value for radius range search field

* **Tabs**
    * Changes between INFO and GPT tabs on itinerary show (itinerary component)

### Spec
* **Features**
    * Dashboard and itinerary index, new and show user story testing

* **Models**
    * Test model validations and methods

* **Services/Facades/Poros**
    * Test API calls and responses

* **Fixtures**
    * Contains *vcr_cassettes* with mocked data used in tests

## Routes
  | Routes | | |
  | - | - | - |
  | get | / | home#home |
  | get | /about | home#about |
  | get | /demo | home#demo |
  | get | /contact | home#contact |
  | post | /contact | contact#create |
  | get | /received | home#received |
  | get | /itineraries | itineraries#index |
  | post | itineraries/prepare | itineraries#prepare |
  | get | /itineraries/new | itineraries#new |
  | post | /itineraries | itineraries#create |
  | get | /itineraries/:id | itineraries#show |
  | delete | /itineraries/:id | itineraries#destroy |
  | delete | /parks/:id | parks#destroy |
  | delete | /businesses/:id | businesses#destroy |
  | get | /404 | errors#not_found |
  | get | /422 | errors#unprocessable |
  | get | /500 | errors#internal_server_error |

  | Devise | (/users) | users/devise |
  | - | - | - |
  | get | /sign_in | devise/sessions#new |
  | post | /sign_in | devise/sessions#create |
  | delete | /sign_out | devise/sessions#destroy |
  | get/post | /auth/google_oauth2 | omniauth_callbacks#passthru |
  | get/post | /auth/google_oauth2/callback | omniauth_callbacks#google_oauth2 |
  | get | /password/new | passwords#new |
  | get | /password/edit | passwords#edit |
  | put | /password | passwords#update |
  | post | /password | passwords#create |
  | get | /cancel | registrations#cancel |
  | get | /sign_up | registrations#new |
  | get | /edit | registrations#edit |
  | put | */users* | registrations#update |
  | delete | */users* | registrations#destroy |
  | post | */users* | registrations#create |

## Endpoints
### [GOOGLE PLACES](https://developers.google.com/maps/documentation/places/web-service/nearby-search)
* Example query:

 `POST https://places.googleapis.com/v1/places:searchNearby`

* Authorization: X-Goog-Api-Key HEADER
* JSON payload: includedTypes, maxResultCount, locationRestriction (latitude, longitude, radius)

### [YELP BUSINESS](https://www.yelp.com/developers/documentation/v3/business_search)
* Example query:

  `GET https://api.yelp.com/v3/businesses/search?term=restaurants&location=Denver&sort_by=distance`

* Authorization: bearer token
* Params: term, location, latitude, longitude, radius, categories, limit, sort_by (rating/distance), price (1 = $, 2 = $$, etc)

### [TRAILAPI](https://rapidapi.com/trailapi/api/trailapi/)
* Example query:

  `GET https://trailapi-trailapi.p.rapidapi.com/activity/?q-country_cont=&q-city_cont=Denver`

* Authorization: X-RapidAPI-Key HEADER
* Params: q-activities_activity_type_name_eq (search activities), lat, lon, limit, country_cont (search country), state_cont (search state), radius (from lat/lon), q-city_cont (city search)

### [GOOGLE GEOCODING](https://developers.google.com/maps/documentation/geocoding/requests-geocoding)
* Example query:

  `GET http://maps.googleapis.com/geocode/json?address=Denver`

* Authorization: key
* Params: address

  4. Run migrations:

    $ rails db:{create,migrate}

  5. Create a .env file and add ENV variables:
    `RAPID_API_KEY`, `YELP_API_KEY` and `GOOGLE_MAPS_KEY` (Functionality), `DEVISE_SECRET_KEY` and `DEVISE_PEPPER` (Devise), `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` (Google Analytics).

  6. Run the application locally:

    $ bin/dev

  7. Visit localhost:3000 on your browser.

  ## Testing
    $ bundle exec rspec