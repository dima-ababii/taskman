Rails.application.routes.draw do
  # Set Default start page
  root to: 'tasks#index'
  
  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new'
    get '/sign_up' => 'devise/registrations#new'
  end
  
  devise_for :users
  
  resources :tasks
  resources :users
end
