require 'librarian/dsl'
require 'librarian/bower/source'

module Librarian
  module Bower
    class DSL < Librarian::Dsl
      dependency :component
      dependency :js
      dependency :css

      source :site => Source::Site
      #source :git => Source::Git
      #source :github => Source::Github
      source :path => Source::Path
    end
  end
end
