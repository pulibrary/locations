class AddOrderToLocationsLibraries < ActiveRecord::Migration
  def change
    add_column :locations_libraries, :order, :integer, default: 0
  end
end
