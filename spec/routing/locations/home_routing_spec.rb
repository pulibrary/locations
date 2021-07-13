# frozen_string_literal: true

require 'spec_helper'

describe Locations::HomeController, type: :routing do
  describe 'routing' do
    routes { Locations::Engine.routes }

    it 'routes to #index' do
      expect(get: '/').to route_to('locations/home#index')
    end
  end
end
