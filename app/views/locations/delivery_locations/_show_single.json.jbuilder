json.extract! delivery_location, :label, :address, :phone_number, :contact_email, :staff_only
# Presently no use case for seeing holding_locations from this side of the association
# json.holding_locations delivery_location.holding_locations do |holding_location|
#   json.partial! 'locations/holding_locations/show_single', holding_location: holding_location
# end
