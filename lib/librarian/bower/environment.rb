require "librarian/environment"
require "librarian/bower/dsl"
require "librarian/bower/source"
require "bowery/version"

module Librarian
  module Bower
    class Environment < Environment
      def adapter_name
        "asset"
      end

      def adapter_version
        Bowery::VERSION
      end

      def install_path
        part = config_db["path"] || "vendor/assets/components"
        project_path.join(part)
      end

      def config_keys
        super + %w[
          install.strip-dot-git
          path
        ]
      end
    end
  end
end
