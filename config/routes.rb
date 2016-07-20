Locations::Engine.routes.draw do
  resources :hours_locations, path_names: { new: "create" }
  resources :holding_locations, path_names: { new: "create" }
  resources :libraries, path_names: { new: "create"} do
    resources :floors, path_names: { new: "create" }
  end
  resources :delivery_locations, path_names: { new: "create"}
  get 'digital_locations', to: 'delivery_locations#digital_locations'
  root 'home#index'
end
