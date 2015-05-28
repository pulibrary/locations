class AddPickupAttrToDeliveryLocation < ActiveRecord::Migration
  def change
    add_column :locations_delivery_locations, :gfa_pickup, :string
    add_column :locations_delivery_locations, :pickup_location, :boolean, default: false
  end
end
