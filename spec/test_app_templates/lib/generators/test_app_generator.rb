require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../spec/fixtures", __FILE__)

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

  def copy_fixture_data
    copy_file 'floorplan.png', 'public/uploads/floorplan.png'
  end

end
