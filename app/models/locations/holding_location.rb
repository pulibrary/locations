module Locations
  class HoldingLocation < ActiveRecord::Base
    include Locations::Labeled
    include Locations::Coded
    include Locations::WithLibrary

    belongs_to :hours_location, class_name: 'Locations::HoursLocation', foreign_key: :locations_hours_location_id

    has_and_belongs_to_many :delivery_locations, -> { uniq },
      class_name: 'Locations::DeliveryLocation',
      join_table: 'locations_holdings_delivery',
      foreign_key: 'locations_delivery_location_id',
      association_foreign_key: 'locations_holding_location_id'

    validates :aeon_location, :recap_electronic_delivery_location, :open,
      :requestable, :always_requestable, inclusion: { in: [true, false] }

    after_create :set_defaults
    after_initialize :associate_non_staff_only_delivery_locations, if: :new_record?

    private
    def set_defaults
      self.aeon_location = false if self.aeon_location.blank?
      self.recap_electronic_delivery_location = false if self.recap_electronic_delivery_location.blank?
      self.open = true if self.open.blank?
      self.requestable = true if self.requestable.blank?
      self.always_requestable = false if self.always_requestable.blank?
    end

    def associate_non_staff_only_delivery_locations
      DeliveryLocation.all.select { |dl| !dl.staff_only? }.each do |public_dl|
        self.delivery_locations << public_dl
      end
    end
  end
end
