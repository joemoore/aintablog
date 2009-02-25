# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

require 'authenticated_model'

Rails::Initializer.run do |config|
  config.load_paths += %W[
      #{RAILS_ROOT}/app/models/posts
      #{RAILS_ROOT}/app/models/feeds
    ]

  config.action_controller.cache_store = :file_store, "#{RAILS_ROOT}/public/cache"
  config.action_controller.session_store = :cookie_store
  config.action_controller.session = {
    :session_key => "_myapp_session",
    :secret      => '98b0d895002199cb583775282101af83d144d9c710a83502497e3ebc79364c79147cf8452d3ffc95d7752e74b8864970b2bf265754e30fee103b7b9d188c4dbe'
  }

  # These gems are totally required
  config.gem 'feed-normalizer'
  # config.gem 'BlueCloth'
  config.gem 'nokogiri'
end


