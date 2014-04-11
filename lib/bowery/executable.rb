require 'thor'
require 'bowery/assetfile'
require 'bowery/bower_config'
require 'pry'

# The executable that installs Bower assets.

module Bowery
  class Executable < Thor
    include Thor::Actions
    include Assetfile

    desc :install, "Install assets from Bower unless already installed"
    def install
      eval assetfile
      BowerConfig.write components
      sh 'bower install'
    end

    desc :export, "Export Sprockets manifest files for installed assets"
    method_option :name, default: 'application'
    method_option :path, default: 'app/assets'
    def export
      eval assetfile
      %w(stylesheets javascripts).each do |type|
        manifest = Manifest.new type, components, options
        create_file manifest.path, manifest.contents
      end
    end

    desc :list, "List all assets managed by Bower"
    def list
      eval assetfile
      components.each { |component| say "#{name} (#{version})" }
    end

    desc :init, "Set up this project for use with Bowery"
    def init
      append_file '.gitignore', "vendor/components"
      create_file 'Assetfile', File.read("spec/dummy/Assetfile")
    end

    private
    def assetfile
      @file ||= File.read "Assetfile"
    end
  end
end
