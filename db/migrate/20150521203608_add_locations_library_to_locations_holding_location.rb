# frozen_string_literal: true

class AddLocationsLibraryToLocationsHoldingLocation < ActiveRecord::Migration[4.2]
  def change
    add_reference :locations_holding_locations, :locations_library, index: true, foreign_key: true
  end
end
