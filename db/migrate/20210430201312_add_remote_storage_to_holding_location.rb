# frozen_string_literal: true

class AddRemoteStorageToHoldingLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations_holding_locations, :remote_storage, :string
  end
end
