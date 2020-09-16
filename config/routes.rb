# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  resources :addresses, only: %i[new create update edit]

  namespace :books do
    resources :search, only: [:index]
  end

  resources :books, only: [:index, :show]

  namespace :user do
    get '/dashboard', to: 'dashboard#show', as: 'dashboard'
    resources :friends, only: [:index, :show]
    resources :friend_requests, only: %i[create update destroy]
    resources :books, only: [:index, :new, :create, :show]
    get '/account', to: 'account#show'
  end

end
