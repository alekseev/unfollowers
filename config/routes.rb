Twi::Application.routes.draw do |map|
  
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'login' => 'user_sessions#new', :as => :login
  match 'authenticate' => 'user_sessions#create', :as => :authenticate#, :via => :post
  match 'signup' => 'users#new', :as => :signup
  match 'connect' => 'users#update', :as => :connect, :via => :post
  match 'email' => 'users#email', :as => :email
  match 'testx' => 'index#testx', :as => :testx
  match 'adduser' => 'index#adduser', :as => :adduser
  match 'users' => 'users#index', :as => :users
  match 'more' => 'index#more', :as => :more
  match 'settings' => 'users#update', :as => :settings
  match 'validate/:code' => 'users#validate', :as => :validate

  match "reset" => "users#detonate"

  map.resources :users
  map.resource :user_session
  map.resources :followers
  
  match 'user/:id' => 'users#show', :as => :profile
  #root :to => "user_sessions#new"
  root :to => "index#index"
  
end