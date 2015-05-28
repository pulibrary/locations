require 'rails/generators'

module Locations
  class InstallGenerator < Rails::Generators::Base

    def add_gems
      gem 'bootstrap-sass', '~> 3.3.4'
      Bundler.with_clean_env do
        run "bundle install"
      end
    end

    def friendly_id
      gem 'friendly_id', '~> 5.1.0'
      generate 'friendly_id'
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