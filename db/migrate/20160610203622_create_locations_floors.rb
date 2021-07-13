# frozen_string_literal: true

class CreateLocationsFloors < ActiveRecord::Migration[4.2]
  def change
    create_table :locations_floors do |t|
      t.string :label
      t.string :floor_plan_image
      t.string :starting_point
      t.string :walkable_areas

      t.timestamps null: false
    end
  end
end
