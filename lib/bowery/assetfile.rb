module Bowery
  class Assetfile
    def initialize(at_path)
      @path = at_path
    end

    def self.parse
      new File.expand_path('./Assetfile')
    end

    def javascripts
      components.where js: true
    end

    def stylesheets
      components.where css: true
    end

    def components
      eval file_contents
    end
  end
end
