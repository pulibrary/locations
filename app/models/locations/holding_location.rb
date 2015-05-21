module Locations
  class HoldingLocation < ActiveRecord::Base
    include Locations::Labeled
    include Locations::Coded
    include Locations::WithLibrary

    has_and_belongs_to_many :delivery_locations,
      class_name: 'Locations::DeliveryLocation',
      join_table: 'locations_holdings_delivery',
      foreign_key: 'locations_delivery_location_id',
      association_foreign_key: 'locations_holding_location_id'

    validates :is_aeon_location, :is_recap_electronic_delivery_location,
      :is_open, :is_requestable, :is_always_requestable,
      inclusion: { in: [true, false] }

    after_initialize :set_defaults

    private
    def set_defaults
      self.is_aeon_location = false if self.is_aeon_location.blank?
      self.is_recap_electronic_delivery_location = false if self.is_recap_electronic_delivery_location.blank?
      self.is_open = true if self.is_open.blank?
      self.is_requestable = true if self.is_requestable.blank?
      self.is_always_requestable = false if self.is_always_requestable.blank?
    end
  end
end
