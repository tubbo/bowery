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
      system "bower install #{id}" unless path.present?
      puts "Installed #{name} at #{version}"
      $?.success?
    end

    # Uninstall this Component with Bower.
    def uninstall
      system "bower uninstall #{id}" unless path.present?
      $?.success?
    end

    # Update to the latest version of this Component with Bower unless
    # it is being managed with a local path.
    def update
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

    # Package identifier, usually consisting of the 'name#version'.
    def id
      if name == package
        "#{package}##{version}"
      else
        "#{name}=#{package}##{version}"
      end
    end

    private
    def usage_msg
      return "Using #{name} at #{version}..." if has_version?
      "Using #{name}..."
    end

    def has_version?
      (not version.nil?) && (not version.empty?)
    end
  end
end
