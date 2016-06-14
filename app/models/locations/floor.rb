module Locations
  class Floor < ActiveRecord::Base
    include Locations::Labeled
    include Locations::WithLibrary

    belongs_to :holding_library, class_name: 'Locations::Library', foreign_key: :holding_library_id
    
  end
end
