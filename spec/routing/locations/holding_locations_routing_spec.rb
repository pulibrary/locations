require 'spec_helper'

describe Locations::HoldingLocationsController, type: :routing do
  describe 'routing' do

    routes { Locations::Engine.routes }

    it 'routes to #index' do
      expect(get: '/holding_locations').to route_to('locations/holding_locations#index')
    end

    it 'routes to #new' do
      expect(get: '/holding_locations/new').to route_to('locations/holding_locations#new')
    end

    it 'routes to #show' do
      expect(get: '/holding_locations/1').to route_to('locations/holding_locations#show', :id => '1')
    end

    it 'routes to #edit' do
      expect(get: '/holding_locations/1/edit').to route_to('locations/holding_locations#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(post: '/holding_locations').to route_to('locations/holding_locations#create')
    end

    it 'routes to #update' do
      expect(put: '/holding_locations/1').to route_to('locations/holding_locations#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/holding_locations/1').to route_to('locations/holding_locations#destroy', :id => '1')
    end

  end
end
