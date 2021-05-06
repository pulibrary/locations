$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'locations/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'locations'
  s.version     = Locations::VERSION
  s.authors     = ['Jon Stroop']
  s.email       = ['jpstroop@gmail.com']
  s.homepage    = 'https://github.com/pulibrary/locations'
  s.summary     = 'Princeton University Locations Service'
  s.description = 'Allows for retrieving and updating PU library locations'
  s.test_files = Dir["spec/**/*"]
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.4'
  s.add_dependency 'bootstrap-sass', '~> 3.3'
  s.add_dependency 'friendly_id', '~> 5.1.0'
  s.add_dependency 'yaml_db', '~> 0.7'
  s.add_dependency 'jquery-tablesorter', '~> 1.21'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.1'
  s.add_development_dependency 'engine_cart', '~> 2.1'
  s.add_development_dependency 'factory_girl_rails', '~> 4.5.0'
  s.add_development_dependency 'faker', '~> 1.9'
  s.add_development_dependency 'database_cleaner', '~> 1.3'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rails-controller-testing'
end
