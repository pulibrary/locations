# frozen_string_literal: true

class CreateLocationsLibraries < ActiveRecord::Migration[4.2]
  def change
    create_table :locations_libraries do |t|
      t.string :label
      t.string :code

      t.timestamps null: false
    end
  end
end
