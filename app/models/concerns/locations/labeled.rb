# frozen_string_literal: true

module Locations
  module Labeled
    extend ActiveSupport::Concern
    included do
      validates :label, presence: true
    end
  end
end
