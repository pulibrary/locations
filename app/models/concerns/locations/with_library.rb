# frozen_string_literal: true

module Locations
  module WithLibrary
    extend ActiveSupport::Concern
    included do
      belongs_to :library, class_name: 'Locations::Library', foreign_key: :locations_library_id
      validates :library, presence: true
    end
  end
end
