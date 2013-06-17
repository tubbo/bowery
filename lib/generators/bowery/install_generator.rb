module Bowery
  class InstallGenerator < Rails::Generators::NamedBase
    def initialize_bowery
      run 'bowery init'
    end

    def initialize_rails_app
      initializer do
        Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/components"
      end
    end
  end
end
