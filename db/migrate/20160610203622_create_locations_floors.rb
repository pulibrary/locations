class CreateLocationsFloors < ActiveRecord::Migration
  def change
    create_table :locations_floors do |t|
      t.string :label
      t.string :floor_plan_uri
      t.string :starting_point
      t.string :walkable_areas

      t.timestamps null: false
    end
  end
end
