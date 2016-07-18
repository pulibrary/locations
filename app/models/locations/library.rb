module Locations
  class Library < ActiveRecord::Base
    has_many :floors, class_name: 'Locations::Floor', foreign_key: :locations_library_id
    include Locations::Labeled
    include Locations::Coded

    accepts_nested_attributes_for :floors,
                                  reject_if: proc { |attributes| attributes['label'].blank? && attributes['floor_plan_image'].blank?},
                                  allow_destroy: true
  end
end
