# frozen_string_literal: true

class AddDigitalLocationToDeliveryLocation < ActiveRecord::Migration[4.2]
  def change
    add_column :locations_delivery_locations, :digital_location, :boolean
  end
end
