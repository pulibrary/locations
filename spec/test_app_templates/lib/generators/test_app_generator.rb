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
    gem 'factory_girl_rails', '~> 4.5.0', group: [:development, :test]
    gem 'faker', '~> 1.4.3', group: [:development, :test]
  end

  def install_engine
    generate 'locations:install', '-f'
  end

end
