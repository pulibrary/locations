class AddLocationsLibraryToLocationsFloors < ActiveRecord::Migration
  def change
    add_reference :locations_floors, :locations_libraries, index: true, foreign_key: true
  end
end
