module Locations
  class Floor < ActiveRecord::Base
    include Locations::Labeled
    include Locations::WithLibrary

    mount_uploader :floor_plan_image, FloorplanUploader

  end
end
