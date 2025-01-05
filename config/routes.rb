# frozen_string_literal: true

Rails.application.routes.draw do
  # dashboard
  root 'home#home'
  get 'about', to: 'home#about'
  get 'demo', to: 'home#demo'

  # users
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # admin
  ActiveAdmin.routes(self)

  # itineraries
  resources :itineraries, except: %i[edit] do
    post 'prepare', on: :collection
  end
  resources :parks, only: %i[destroy]
  resources :businesses, only: %i[destroy] do
    patch :favorite, on: :member
  end

  # stripe
  post 'checkout', to: 'stripe#checkout'
  post 'webhooks', to: 'webhooks#receive'

  # posts
  resources :posts, only: %i[index show] do
    resources :comments, only: %i[create destroy]
  end

  # contact
  get 'contact',  to: 'home#contact'
  post 'contact', to: 'contact#create'
  get 'received', to: 'home#received'

  # errors
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unprocessable'
  get '/500', to: 'errors#internal_error'
end
