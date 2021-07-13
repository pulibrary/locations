# frozen_string_literal: true

require 'spec_helper'

describe Locations::HoursLocationsController, type: :routing do
  describe 'routing' do
    routes { Locations::Engine.routes }

    it 'routes to #index' do
      expect(get: '/hours_locations').to route_to('locations/hours_locations#index')
    end

    it 'routes to #create' do
      expect(get: '/hours_locations/create').to route_to('locations/hours_locations#new')
    end

    it 'routes to #show' do
      expect(get: '/hours_locations/firestone').to route_to('locations/hours_locations#show', id: 'firestone')
    end

    it 'routes to #edit' do
      expect(get: '/hours_locations/firestone/edit').to route_to('locations/hours_locations#edit', id: 'firestone')
    end

    it 'routes to #create' do
      expect(post: '/hours_locations').to route_to('locations/hours_locations#create')
    end

    it 'routes to #update' do
      expect(put: '/hours_locations/firestone').to route_to('locations/hours_locations#update', id: 'firestone')
    end

    it 'routes to #destroy' do
      expect(delete: '/hours_locations/firestone').to route_to('locations/hours_locations#destroy', id: 'firestone')
    end
  end
end
