module Locations
  class Floor < ActiveRecord::Base
    include Locations::Labeled
  end
end
