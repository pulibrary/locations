require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "../../spec/test_app_templates"

  # if you need to generate any additional configuration
  # into the test app, this generator will be run immediately
  # after setting up the application

  # def install_engine
  #   generate 'locations:install'
  # end

  def add_gems
    gem 'bootstrap-sass', '~> 3.3'
    gem 'yaml_db', '~> 0.3.0'
    gem 'factory_girl_rails', '~> 4.5.0', group: [:development, :test]
    gem 'faker', '~> 1.4.3', group: [:development, :test]
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
    rake "db:migrate RAILS_ENV=test"
  end

end
