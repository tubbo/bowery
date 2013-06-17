require 'librarian/bower/component'

module Librarian
  module Bower::Source
    module Local
      def install! component
        raise ArgumentError unless component.source == self

        from_path = found_path_for component.name
        to_path = environment.install_path.join(component.name)

        if to_path.exist?
          debug { "Deleting previous installation of #{component.name}" }
          to_path.rmtree
        end

        install_perform_step_copy! from_path, to_path
      end

      def fetch_version name, extra
        component = Librarian::Bower::Component.where name: name
        component.version rescue nil
      end

      def fetch_dependencies name, version, extra
        component = Librarian::Bower::Component.where \
          name: name, version: version
        component.dependencies rescue []
      end

    private
      def install_perform_step_copy! found_path, install_path
        FileUtils.mkdir_p install_path
        FileUtils.cp_r found_path, install_path
      end
    end
  end
end
