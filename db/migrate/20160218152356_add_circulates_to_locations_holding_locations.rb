class AddCirculatesToLocationsHoldingLocations < ActiveRecord::Migration
  def change
    add_column :locations_holding_locations, :circulates, :boolean, default: true
    reversible do |direction|
      direction.up { Locations::HoldingLocation.update_all(circulates: true) }
    end
  end
end
