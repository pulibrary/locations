module Locations
  module Coded
    extend ActiveSupport::Concern
    included do
      validates :code, presence: true
      validates :code, uniqueness: true
      validates_format_of :code, with: /\A[a-z][a-z0-9]{2,10}\Z/,
        message: 'Code must at least three characters, all lowercase letters or numbers, and may not start with a number'
    end
  end
end