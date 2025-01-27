# frozen_string_literal: true

Rails.application.routes.draw do
  # home
  root 'home#home'
  get 'test', to: 'test#test'

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
  post 'cancel', to: 'stripe#cancel'
  post 'resub', to: 'stripe#resub'
  post 'webhooks', to: 'webhooks#receive'

  # posts
  resources :posts, only: %i[index show] do
    resources :comments, only: %i[create destroy]
  end

  # contact
  get 'contact',  to: 'contact#contact'
  post 'contact', to: 'contact#create'
  get 'received', to: 'contact#received'

  # errors
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unprocessable'
  get '/500', to: 'errors#internal_error'
end
