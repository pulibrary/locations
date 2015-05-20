module Locations
  class Library < ActiveRecord::Base
    validates :code, uniqueness: true
    validates :label, :code, presence: true
  end
end
