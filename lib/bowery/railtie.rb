require 'rails/railtie'

module Bowery
  # When integrated with a Rails project, this configures Sprockets so
  # that Bower components are available within the asset pipeline
  # automatically.
  class Railtie < Rails::Railtie
    initializer "add bower components path to sprockets" do
      if config.assets.present?
        config.assets.paths << 'vendor/components'
      end
    end
  end
end
