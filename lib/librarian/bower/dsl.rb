require 'librarian/dsl'
require 'librarian/bower/source'

module Librarian
  module Bower
    class Dsl < Librarian::Dsl
      dependency :component

      source :site => Source::Site
      #source :git => Source::Git
      #source :github => Source::Github
      source :path => Source::Path
    end
  end
end
