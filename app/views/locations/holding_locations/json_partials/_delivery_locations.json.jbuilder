json.delivery_locations delivery_locations do |delivery_location|
  json.partial! 'locations/delivery_locations/show_single',
    delivery_location: delivery_location
end
