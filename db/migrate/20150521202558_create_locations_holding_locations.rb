class CreateLocationsHoldingLocations < ActiveRecord::Migration
  def change
    create_table :locations_holding_locations do |t|
      t.string :label
      t.string :code

      t.timestamps null: false
    end
  end
end
