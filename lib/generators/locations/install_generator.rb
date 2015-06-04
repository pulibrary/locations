require 'rails/generators'

module Locations
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../locations', __FILE__)

    def add_gems
      gem 'bootstrap-sass'
      gem 'yaml_db', '~> 0.3.0'
      Bundler.with_clean_env do
        run "bundle install"
      end
    end

    def friendly_id
      gem 'friendly_id', '~> 5.1.0'
      generate 'friendly_id'
      gsub_file 'config/initializers/friendly_id.rb', 'new edit', 'create edit'
    end

    def inject_routes
      inject_into_file 'config/routes.rb', after: %Q(Rails.application.routes.draw do\n) do
        %Q(  mount Locations::Engine, at: '/locations'\n)\
      end
    end

    def run_migrations
      rake 'locations:install:migrations'
      rake "db:migrate"
    end

  end
end