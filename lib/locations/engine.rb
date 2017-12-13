module Locations
  class Engine < ::Rails::Engine
    require 'jquery-tablesorter'

    isolate_namespace Locations
    config.generators do |g|
      g.test_framework :rspec, view_specs: false, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
