require 'librarian/helpers'
require 'librarian/cli'
require 'librarian/bower'
require 'librarian/bower/dsl'

module Bowery
  class CLI < Librarian::Cli
    source_root Pathname.new(__FILE__).dirname.join("templates")

    module Particularity
      def root_module
        Librarian::Bower
      end
    end

    extend Particularity

    desc :install, "Install assets to your components directory"
    def install
      ensure!
      clean! if options[:clean]
      resolve!
      install!
    end

    desc :init, "Initializes this install of Bowery"
    def init
      copy_file 'Assetfile'
      copy_file '.bowerrc'
    end
  end
end
