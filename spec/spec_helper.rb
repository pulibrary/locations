ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../spec/internal/config/environment', __FILE__)
require 'factory_girl_rails'
require 'rspec/rails'
require 'engine_cart'
require 'database_cleaner'

EngineCart.load_application!

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

FactoryGirl.definition_file_paths = [File.expand_path("../factories", __FILE__)]
FactoryGirl.find_definitions

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  config.before :each do

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end
  config.after :each do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include Locations::Engine.routes.url_helpers

  config.include FactoryGirl::Syntax::Methods

end
