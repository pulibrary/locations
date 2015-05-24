class AddAdditionalFieldsToHoldingLocation < ActiveRecord::Migration
  def change
    add_column :locations_holding_locations, :aeon_location, :boolean, default: false
    add_column :locations_holding_locations, :recap_electronic_delivery_location, :boolean, default: false
    add_column :locations_holding_locations, :open, :boolean, default: true
    add_column :locations_holding_locations, :requestable, :boolean, default: true
    add_column :locations_holding_locations, :always_requestable, :boolean, default: false
  end
end
