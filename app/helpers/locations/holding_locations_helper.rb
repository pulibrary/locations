module Locations
  module HoldingLocationsHelper
    def boolean_properties_labels
      {
        is_aeon_location: 'This is an Aeon request location',
        is_recap_electronic_delivery_location: 'Items in the location are eligible for electronic delivery from ReCAP',
        is_open: 'This is an open location',
        is_requestable: 'Items in this location are requestable',
        is_always_requestable: 'Items in this location are always requestable, even when checked out'
      }
    end
  end
end
