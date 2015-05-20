$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'locations/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'locations'
  s.version     = Locations::VERSION
  s.authors     = ['Jon Stroop']
  s.email       = ['jpstroop@gmail.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of Locations.'
  s.description = 'TODO: Description of Locations.'
  s.test_files = Dir["spec/**/*"]
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 4.2.1'
  s.add_dependency 'bootstrap-sass', '~> 3.3.4'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.1'
  s.add_development_dependency 'engine_cart'
  s.add_development_dependency 'factory_girl_rails', '~> 4.5.0'
  s.add_development_dependency 'faker', '~> 1.4.3'
  s.add_development_dependency 'database_cleaner', '~> 1.3'
end
