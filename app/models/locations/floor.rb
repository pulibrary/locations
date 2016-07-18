module Locations
  class Floor < ActiveRecord::Base
    include Locations::Labeled
    belongs_to :library, class_name: 'Locations::Library', foreign_key: :locations_library_id

    mount_uploader :floor_plan_image, FloorplanUploader

  end
end
