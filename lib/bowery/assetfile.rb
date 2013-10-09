module Bowery
  class Assetfile
    def initialize(at_path)
      @file_path = at_path
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
      Components.from file_contents
    end

    private
    attr_reader :file_path

    def file_contents
      @contents ||= IO.read file_path
    end
  end
end
