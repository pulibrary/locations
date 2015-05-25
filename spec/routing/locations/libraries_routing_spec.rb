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
      expect(get: '/libraries/firestone').to route_to('locations/libraries#show', id: 'firestone')
    end

    it 'routes to #edit' do
      expect(get: '/libraries/firestone/edit').to route_to('locations/libraries#edit', id: 'firestone')
    end

    it 'routes to #create' do
      expect(post: '/libraries').to route_to('locations/libraries#create')
    end

    it 'routes to #update' do
      expect(put: '/libraries/firestone').to route_to('locations/libraries#update', id: 'firestone')
    end

    it 'routes to #destroy' do
      expect(delete: '/libraries/firestone').to route_to('locations/libraries#destroy', id: 'firestone')
    end

  end
end
