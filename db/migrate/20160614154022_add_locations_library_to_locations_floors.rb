# frozen_string_literal: true

class AddLocationsLibraryToLocationsFloors < ActiveRecord::Migration[4.2]
  def change
    add_reference :locations_floors, :locations_library, index: true, foreign_key: true
  end
end
