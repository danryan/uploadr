require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = "random"
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
  config.filter_run_excluding external: true
end

def fixture_path
  File.expand_path("../support/fixtures", __FILE__)
end

def fixture
  File.new(fixture_path + '/' + file)
end

def json_response(file)
  {
    body: fixture(file),
    headers: {
      content_type: 'application/json; charset=utf-8'
    }
  }
end