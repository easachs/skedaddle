# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'home#home'
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
  get 'received', to: 'home#received'

  resources :itineraries, except: %i[edit update]
  resources :parks, only: %i[destroy]
  resources :businesses, only: %i[destroy]

  post 'contact', to: 'contact#create'
end
