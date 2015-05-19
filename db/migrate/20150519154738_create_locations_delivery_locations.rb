class CreateLocationsDeliveryLocations < ActiveRecord::Migration
  def change
    create_table :locations_delivery_locations do |t|
      t.string :label
      t.text :address
      t.string :phone
      t.string :contact_mail
      t.boolean :staff_only

      t.timestamps null: false
    end
  end
end