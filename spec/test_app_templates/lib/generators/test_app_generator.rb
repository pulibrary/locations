require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "../../spec/test_app_templates"

  # if you need to generate any additional configuration
  # into the test app, this generator will be run immediately
  # after setting up the application

  # def install_engine
  #   generate 'locations:install'
  # end

  def inject_routes
    inject_into_file 'config/routes.rb', after: %Q(Rails.application.routes.draw do\n) do
      %Q(  mount Locations::Engine, at: '/locations'\n)\
    end
  end

  def copy_migrations
    rake 'locations:install:migrations'
  end

  def run_migrations
    rake "db:migrate"
  end
end
