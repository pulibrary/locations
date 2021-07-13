# frozen_string_literal: true

module Locations
  class DeliveryLocation < ActiveRecord::Base
    include Locations::Labeled
    include Locations::WithLibrary

    has_and_belongs_to_many :holding_locations, -> { distinct },
                            class_name: 'Locations::HoldingLocation',
                            join_table: 'locations_holdings_delivery',
                            foreign_key: 'locations_holding_location_id',
                            association_foreign_key: 'locations_delivery_location_id'

    validates :address, :phone_number, :contact_email, :gfa_pickup, presence: true
    validates :staff_only, :pickup_location, :digital_location, inclusion: { in: [true, false] }
    after_initialize :set_defaults

    private

    def set_defaults
      self.staff_only = false if staff_only.blank?
      self.pickup_location = false if pickup_location.blank?
      self.digital_location = false if digital_location.blank?
    end
  end
end
