require 'rails/generators'

module Locations
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../locations', __FILE__)

    def add_gems
      gem 'bootstrap-sass'
      gem 'yaml_db', '~> 0.6'
      gem 'jquery-rails'
      Bundler.with_clean_env do
        run "bundle install"
      end
    end

    def friendly_id
      gem 'friendly_id', '~> 5.1.0'
      generate 'friendly_id'
      migration_file =  Dir['db/migrate/*_create_friendly_id_slugs.rb'].first
      inject_into_file migration_file, after: 'ActiveRecord::Migration' do
        '[4.2]'
      end
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
