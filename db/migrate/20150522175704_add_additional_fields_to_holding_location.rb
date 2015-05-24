class AddAdditionalFieldsToHoldingLocation < ActiveRecord::Migration
  def change
    add_column :locations_holding_locations, :is_aeon_location, :boolean, default: false
    add_column :locations_holding_locations, :is_recap_electronic_delivery_location, :boolean, default: false
    add_column :locations_holding_locations, :is_open, :boolean, default: true
    add_column :locations_holding_locations, :is_requestable, :boolean, default: true
    add_column :locations_holding_locations, :is_always_requestable, :boolean, default: false
  end
end
