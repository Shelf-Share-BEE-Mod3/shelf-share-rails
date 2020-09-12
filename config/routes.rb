Rails.application.routes.draw do
  root 'welcome#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get '/dashboard', to: 'dashboard#show', as: 'dashboard'
  resources :books, only: [:index]

  namespace :user do
    resources :friends, only: [:index]
    resources :books, only: [:index]
    get '/account', to: 'account#show', as: 'account'
  end
end
