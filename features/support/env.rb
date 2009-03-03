# Sets up the Rails environment for Cucumber
MOCK_ROOT = File.dirname(__FILE__) + '/../../test/mocks' unless defined?(MOCK_ROOT)
# require 'thoughtbot-factory_girl'
#require 'test/test_helper'
require 'test/factories'

ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/formatters/unicode' # Comment out this line if you don't want Cucumber Unicode support
# require 'spec/spec_helper'

Cucumber::Rails.use_transactional_fixtures

#Seed the DB
# Fixtures.reset_cache   
# fixtures_folder = File.join(RAILS_ROOT, 'test', 'fixtures')
# fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
# Fixtures.create_fixtures(fixtures_folder, fixtures)


require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
require 'webrat/rspec-rails'
