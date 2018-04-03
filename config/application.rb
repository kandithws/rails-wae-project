require_relative 'boot'

require 'rails/all'
require 'paper_trail'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module WaeProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.generators do |g|
      g.test_framework :test_unit
    end

    # config.app_generators.javascript_engine :typescript
    # Enable the asset pipeline
    # config.assets.enabled = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
