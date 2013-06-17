require 'librarian/bower/manifest_reader'
require 'librarian/bower/source/base'

module Librarian
  module Bower::Source
    class Site
      include Librarian::Bower::Source::Base
      attr_reader :environment, :uri

      lock_name 'SITE'
      spec_options []

      def initialize environment, uri, options={}
        @environment = environment
        @uri = uri
      end

      def to_s
        uri
      end

      def == other
        other &&
        self.class == other.class &&
        self.uri == other.uri
      end

      def to_spec_args
        [uri, {}]
      end

      def to_lock_options
        { remote: uri }
      end

      def pinned?
        false
      end

      def unpin
      end

      def install! component
        raise ArgumentError unless component.source == self
        info { "Installing #{component.name} (#{component.version})" }
        debug { "Installing #{component}" }
        `bower install #{component} --version=#{component.version}`
      end

      def manifests name
      end

      def cache_path
      end

      def install_path name
        environment.install_path.join name
      end

      def fetch_version name, version_uri
        assets(name).to_version(version_uri)
      end

      def fetch_dependencies name, version, version_uri
        assets(name).version_dependencies(version)
      end

    private
      def assets component_name
        components[name] ||= Bowery.assetfile.find_component name
      end
    end
  end
end
