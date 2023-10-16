# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#home'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'
  get '/about', to: 'home#about'

  resources :itineraries, except: %i[edit update]
  resources :parks, only: %i[destroy]
  resources :businesses, only: %i[destroy]

  get '/contact', to: 'contact#new'
  post '/contact', to: 'contact#create'
end
