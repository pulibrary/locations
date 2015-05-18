$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "locations/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "locations"
  s.version     = Locations::VERSION
  s.authors     = ["Jon Stroop"]
  s.email       = ["jpstroop@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Locations."
  s.description = "TODO: Description of Locations."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails', '~> 3.1'
  s.add_development_dependency 'engine_cart'
end
