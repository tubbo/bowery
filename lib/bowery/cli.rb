require 'librarian/helpers'
require 'librarian/cli'
require 'librarian/bower'

module Bowery
  class CLI < Librarian::Cli
    source_root Pathname.new(__FILE__).dirname.join("templates")

    def install
      ensure!
      clean! if options[:clean]
      resolve!
      install!
    end
  end
end
