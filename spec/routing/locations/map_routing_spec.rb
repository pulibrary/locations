require 'spec_helper'

describe Locations::LibrariesController, type: :routing do
  describe 'routing' do

    routes { Locations::Engine.routes }

    it 'routes to #index' do
      expect(get: '/map').to route_to('locations/map#index')
    end

  end
end
