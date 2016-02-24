module Locations
  module HoldingLocationsHelper
    def boolean_properties_labels
      {
        aeon_location: 'This is an Aeon request location',
        recap_electronic_delivery_location: 'Items in the location are eligible for electronic delivery from ReCAP',
        open: 'This is an open location',
        requestable: 'Items in this location are requestable',
        always_requestable: 'Items in this location are always requestable, even when checked out',
        circulates: 'Items in this location circulate'
      }
    end

    def hours_render(hl)
      hl.hours_location.nil? ? '' : link_to(hl.hours_location.code, hl.hours_location)
    end
  end
end
