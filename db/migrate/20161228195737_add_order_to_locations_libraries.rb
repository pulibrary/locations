# frozen_string_literal: true

class AddOrderToLocationsLibraries < ActiveRecord::Migration[4.2]
  def change
    add_column :locations_libraries, :order, :integer, default: 0
  end
end
