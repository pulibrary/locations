module Locations
  class HoursLocation < ActiveRecord::Base
    include Locations::Labeled
    include Locations::Coded  	
  end
end
