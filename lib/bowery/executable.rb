require 'thor'
require 'bowery/assetfile'
require 'bowery/bower_config'
require 'pry'

# The executable that installs Bower assets.

module Bowery
  class Executable < Thor
    include Thor::Actions
    include Componentfile

    desc :install, "Install assets from Bower unless already installed"
    method_option :dry_run, default: false
    def install
      read_component_file!
      configure
      run 'bower install' unless options[:dry_run]
      say "Bower components have been installed to ./vendor/components"
    end

    desc :configure, "Write the bower.json file from components"
    def configure
      BowerConfig.write components
    end

    desc :export, "Export Sprockets manifest files for installed assets"
    method_option :name, default: 'application'
    method_option :path, default: 'app/assets'
    def export
      read_component_file! and export_manifests
    end

    desc :list, "List all assets managed by Bower"
    def list
      read_component_file!
      components.each { |component| say "#{name} (#{version})" }
    end

    desc :init, "Set up this project for use with Bowery"
    def init
      append_file '.gitignore', "vendor/components"
      template 'Componentfile'
      template '.bowerrc'
    end

    # The directory where we're storing templates for the files that are
    # generated.
    def self.source_root
      File.expand_path '../templates'
    end

    private
    def read_component_file!
      raise ArgumentError, "Componentfile not found" \
        unless component_file_exists?
      eval component_file
    end

    def component_file
      @component_file ||= File.read component_file_path
    end

    def component_file_path
      File.expand_path "./Componentfile"
    end

    def component_file_exists?
      File.exists? component_file_path
    end

    def export_manifests(options)
      %w(stylesheets javascripts).each do |type|
        manifest = Manifest.new type, components, options
        create_file manifest.path, manifest.contents
      end
    end
  end
end
