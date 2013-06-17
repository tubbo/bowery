require 'librarian/source/basic_api'

module Librarian
  module Bower::Source
    module Base
      def info *args, &block
        environment.logger.info(*args, &block)
      end

      def debug *args, &block
        environment.logger.debug(*args, &block)
      end
    end
  end
end
