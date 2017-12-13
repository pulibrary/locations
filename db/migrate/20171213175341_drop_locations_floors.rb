class DropLocationsFloors < ActiveRecord::Migration[4.2]
  def change
    drop_table :locations_floors
  end
end
