Locations::Engine.routes.draw do
  resources :holding_locations
  resources :libraries
  resources :delivery_locations
  root 'home#index'
end
