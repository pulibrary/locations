# frozen_string_literal: true

module Locations
  class HoldingLocation < ActiveRecord::Base
    include Locations::Coded
    include Locations::WithLibrary

    belongs_to :hours_location, class_name: 'Locations::HoursLocation', foreign_key: :locations_hours_location_id, optional: true
    belongs_to :holding_library, class_name: 'Locations::Library', foreign_key: :holding_library_id, optional: true

    has_and_belongs_to_many :delivery_locations, -> { distinct },
                            class_name: 'Locations::DeliveryLocation',
                            join_table: 'locations_holdings_delivery',
                            foreign_key: 'locations_delivery_location_id',
                            association_foreign_key: 'locations_holding_location_id'

    validates :aeon_location, :recap_electronic_delivery_location, :open,
              :requestable, :always_requestable, :circulates, inclusion: { in: [true, false] }

    after_create :set_defaults
    after_initialize :associate_non_staff_only_delivery_locations, if: :new_record?

    private

    def set_defaults
      self.aeon_location = false if aeon_location.blank?
      self.recap_electronic_delivery_location = false if recap_electronic_delivery_location.blank?
      self.open = true if self.open.blank?
      self.requestable = true if requestable.blank?
      self.always_requestable = false if always_requestable.blank?
      self.circulates = true if circulates.blank?
    end

    def associate_non_staff_only_delivery_locations
      DeliveryLocation.all.reject(&:staff_only?).each do |public_dl|
        delivery_locations << public_dl
      end
    end
  end
end
