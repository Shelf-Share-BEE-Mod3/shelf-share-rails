Rails.application.routes.draw do
  root 'welcome#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  resources :books, only: [:index]

  namespace :user do
    get '/dashboard', to: 'dashboard#show', as: 'dashboard'
    resources :friends, only: [:index]
    resources :books, only: [:index]
    get '/account', to: 'account#show', as: 'account'
  end
end
