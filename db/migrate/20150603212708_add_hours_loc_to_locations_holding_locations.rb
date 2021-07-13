# frozen_string_literal: true

class AddHoursLocToLocationsHoldingLocations < ActiveRecord::Migration[4.2]
  def change
    add_reference :locations_holding_locations, :locations_hours_location, foreign_key: true
  end
end
