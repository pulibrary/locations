module Locations
  class DeliveryLocation < ActiveRecord::Base
    belongs_to :library, class_name: 'Locations::Library', foreign_key: :locations_library_id
    validates :label, :address, :phone_number, :contact_email, :staff_only, :library, presence: true
    after_initialize :set_defaults

    private
    def set_defaults
      self.staff_only = false if self.staff_only.blank?
    end

  end
end
