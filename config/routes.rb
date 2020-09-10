Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#create'
end
