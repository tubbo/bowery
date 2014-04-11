require 'active_model'

# Components are created from the `component`, `js`, and `css`
# statements in the Componentfile. They are used to install and update Bower
# packages as well as for writing out manifest files.

module Bowery
  class Component
    include ActiveModel::Model

    attr_accessor :name, :version, :js, :css, :path, :git, :github

    # Install this Component with Bower unless it is being managed with
    # a local path.
    def install
      return if path.present?
      system "bower install #{package}##{version}"
    end

    # Uninstall this Component with Bower.
    def uninstall
      return if path.present?
      system "bower uninstall #{package}"
    end

    # Update to the latest version of this Component with Bower unless
    # it is being managed with a local path.
    def update
      return if path.present?
      uninstall and install
    end

    # The package name of this Component, being fetched by Bower.
    def package
      case
      when github.present?
        "https://github.com/#{github}"
      when git.present?
        git
      else
        name
      end
    end
  end
end
