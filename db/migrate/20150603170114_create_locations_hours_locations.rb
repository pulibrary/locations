class CreateLocationsHoursLocations < ActiveRecord::Migration
  def change
    create_table :locations_hours_locations do |t|
      t.string :code
      t.string :label

      t.timestamps null: false
    end
  end
end
