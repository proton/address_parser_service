# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

ENV['RACK_ENV'] = 'test'
require File.expand_path '../../env.rb', __FILE__

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock

  c.around_http_request do |request|
    cassette = request.uri.split('://').last.split('?').first
    VCR.use_cassette(cassette, record: :new_episodes, match_requests_on: %i(method uri body), &request)
  end
end

