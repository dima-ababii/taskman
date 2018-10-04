Rails.application.routes.draw do
  # Set Default start page
  root to: 'tasks#index'
  
  # Routes
  devise_for :users
  
  resources :tasks
  resources :users
end
