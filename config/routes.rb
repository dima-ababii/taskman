Rails.application.routes.draw do
  # Set Default start page
  root to: 'users#index'
  
  # Routes
  devise_for :users
  
  resources :tasks
  resources :users
end
