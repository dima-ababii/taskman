Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # Set Default start page
  root to: 'tasks#index'
  
  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new'
    get '/sign_up' => 'devise/registrations#new'
  end
  
  devise_for :users
  
  resources :tasks do
    member do
      get :assign
      get :download
      get :unassign
    end
    
    collection do
      post ':id/change_state/:state', to: 'tasks#change_state', as: :change_state
    end
  end
  resources :users
end
