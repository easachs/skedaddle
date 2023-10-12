# frozen_string_literal: true

Rails.application.routes.draw do
  root 'dashboard#home'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/dashboard', to: 'dashboard#dashboard'
  delete '/sessions', to: 'sessions#destroy'
  get '/about', to: 'dashboard#about'

  resources :itineraries, except: %i[edit update]
  resources :parks, only: %i[destroy]
  resources :restaurants, only: %i[destroy]

  get '/contact', to: 'contact#new'
  post '/contact', to: 'contact#create'
end
