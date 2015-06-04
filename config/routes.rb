Locations::Engine.routes.draw do
  resources :hours_locations, path_names: { new: "create" }
  resources :holding_locations, path_names: { new: "create" }
  resources :libraries, path_names: { new: "create"}
  resources :delivery_locations, path_names: { new: "create"}
  root 'home#index'
end
