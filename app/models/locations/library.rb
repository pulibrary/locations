# frozen_string_literal: true

module Locations
  class Library < ActiveRecord::Base
    include Locations::Labeled
    include Locations::Coded
  end
end
