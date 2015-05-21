module Locations
  module Coded
    extend ActiveSupport::Concern
    included do
      validates :code, presence: true
      validates :code, uniqueness: true
    end
  end
end
