require 'spec_helper'

describe Locations::LibrariesController, type: :routing do
  describe 'routing' do

    routes { Locations::Engine.routes }

    it 'routes to #index' do
      expect(get: '/libraries').to route_to('locations/libraries#index')
    end

    it 'routes to #new' do
      expect(get: '/libraries/new').to route_to('locations/libraries#new')
    end

    it 'routes to #show' do
      expect(get: '/libraries/1').to route_to('locations/libraries#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/libraries/1/edit').to route_to('locations/libraries#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/libraries').to route_to('locations/libraries#create')
    end

    it 'routes to #update' do
      expect(put: '/libraries/1').to route_to('locations/libraries#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/libraries/1').to route_to('locations/libraries#destroy', id: '1')
    end

  end
end
