ENV['RAILS_ENV'] ||= 'test'

require 'coveralls'

Coveralls.wear!('rails') do
  add_filter '/lib/generators/locations/install_generator.rb'
  add_filter '/lib/locations/version.rb'
end

require File.expand_path('../../.internal_test_app/config/environment', __FILE__)
require 'factory_girl_rails'
require 'rspec/rails'
require 'engine_cart'
require 'database_cleaner'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

EngineCart.load_application!

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

FactoryGirl.definition_file_paths = [File.expand_path("../factories", __FILE__)]
FactoryGirl.find_definitions

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  config.use_transactional_fixtures = false

  config.before :suite  do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before :each do
    DatabaseCleaner.strategy = :transaction
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
  config.global_fixtures = :all

  def fixture(file)
    File.open(File.join(File.dirname(__FILE__), 'fixtures', file), 'rb')
  end

  config.infer_spec_type_from_file_location!

  config.include Locations::Engine.routes.url_helpers

  config.include FactoryGirl::Syntax::Methods

end
