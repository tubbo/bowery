require 'rails'

module Bowery
  class Railtie < Rails::Railtie
    config.bowery = ActiveSupport::OrderedOptions.new

    rake_tasks do
      load 'lib/tasks/bowery.rake'
    end
  end
end
