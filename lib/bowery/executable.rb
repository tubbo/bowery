require 'thor'
require 'bowery/bower'

# The executable that installs Bower assets.

module Bowery
  class Executable < Thor
    include Thor::Actions
    include Bower
    include Assetfile

    desc :install, "Install assets from Bower unless already installed"
    def install
      load './Assetfile'
      components.install
      BowerConfig.write components
      say "All assets have been installed."
    end

    desc :update, "Update all assets to version specified in Assetfile"
    def update
      load './Assetfile'
      components.update
      BowerConfig.write components
      say "All assets have been updated."
    end

    desc :export, "Export manifest files"
    method_option :name, default: 'application'
    method_option :path, default: 'app/assets'
    def export
      load './Assetfile'
      %w(stylesheets javascripts).each do |type|
        manifest = Manifest.new type, components, options

        if manifest.save
          say "Saved #{type} manifest to #{manifest.path}."
        else
          say "Error saving #{type} manifest."
        end
      end
    end

    private
    def resolve asset
      if asset.installed?
        say "Using #{asset.name} (#{asset.version})..."
      else
        say "Installing #{asset.name} (#{asset.version})..."
        bower :install, asset.name, asset.version
      end
    end

    def assets
      @assetfile ||= Assetfile.parse
    end
  end
end
