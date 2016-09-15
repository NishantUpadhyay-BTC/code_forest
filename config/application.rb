require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodeForest
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths = %W(#{config.root}/app/services)
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.paths << Rails.root.join("lib")
    config.active_record.raise_in_transactional_callbacks = true
  end
end
