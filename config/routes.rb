# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#home'
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
  get 'auth/:provider/callback', to: 'sessions#create'
  delete 'sessions', to: 'sessions#destroy'

  resources :itineraries, except: %i[edit update]
  resources :parks, only: %i[destroy]
  resources :businesses, only: %i[destroy]

  post 'contact', to: 'contact#create'
end
