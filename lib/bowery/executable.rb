require 'thor'

# The executable that installs Bower assets.

module Bowery
  class Executable < Thor
    include Thor::Actions

    desc :install, "Install assets from Bower unless already installed"
    def install
      assets.each do |asset|
        resolve asset
      end
    end

    desc :update, "Update all assets to version specified in Assetfile"
    def update
      assets.reload
      assets.each do |asset|
        resolve asset
      end
    end

    desc :export, "Export manifest files"
    method_option :name, default: 'app/assets'
    method_option :path, default: 'application'
    def export
      %w(stylesheets javascripts).each do |type|
        manifest = Manifest.new type, assets, options

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
        run "bower install #{asset.name} -v=#{asset.version}"
      end

      say "Installing #{asset.name} (#{asset.version})..."
    end

    def assets
      @assetfile ||= Assetfile.parse
    end
  end
end
