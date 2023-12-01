# frozen_string_literal: true

Rails.application.routes.draw do
  # dashboard
  root 'home#home'
  get 'about', to: 'home#about'

  # devise
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # itineraries
  resources :itineraries, except: %i[edit update] do
    post 'prepare', on: :collection
  end
  resources :parks, only: %i[destroy]
  resources :businesses, only: %i[destroy]

  # contact
  get 'contact', to: 'home#contact'
  post 'contact', to: 'contact#create'
  get 'received', to: 'home#received'

  # errors
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'
end
