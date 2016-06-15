module Locations
  class Floor < ActiveRecord::Base
    include Locations::Labeled
    include Locations::WithLibrary

  end
end
