json.array!(@delivery_locations) do |delivery_location|
  json.partial! 'locations/delivery_locations/show_single', delivery_location: delivery_location
  if Rails.env.test?
    json.path delivery_location_path(delivery_location, format: :json)
  else
    json.url delivery_location_url(delivery_location, format: :json)
  end
  

end
