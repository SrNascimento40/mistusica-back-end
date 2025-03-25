require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mistusica
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    
    config.action_controller.allow_browser_request_format = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://127.0.0.1:5500', 'https://srnascimento40.github.io'
        resource '*', 
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

    config.middleware.use Rack::ContentType, 'application/json'
  end
end
