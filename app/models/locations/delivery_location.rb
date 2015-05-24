module Locations
  class DeliveryLocation < ActiveRecord::Base
    include Locations::Labeled
    include Locations::WithLibrary

    has_and_belongs_to_many :holding_locations, -> { uniq },
      class_name: 'Locations::HoldingLocation',
      join_table: 'locations_holdings_delivery',
      foreign_key: 'locations_holding_location_id',
      association_foreign_key: 'locations_delivery_location_id'

    validates :address, :phone_number, :contact_email, presence: true
    validates :staff_only, inclusion: { in: [true, false] }
    after_initialize :set_defaults

    private
    def set_defaults
      self.staff_only = false if self.staff_only.blank?
    end

  end
end
