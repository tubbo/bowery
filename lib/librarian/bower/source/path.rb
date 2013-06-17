require 'librarian/source/path'
require 'librarian/bower/source/local'

module Librarian
  module Bower::Source
    class Path < Librarian::Source::Path
      include Local
    end
  end
end
