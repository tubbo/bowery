require 'enumerable'

module Bowery
  class Components
    include Enumerable

    def initialize text
      @text = text
    end

    def self.from assetfile_contents
      new assetfile_contents
    end

    def each
      collection.each { |component| yield component }
    end

    def where options
      select do |component|
        options.keys.reduce(false) do |res,opt|
          res ||= component.send(opt) == options[opt]
        end
      end
    end

    private
    def collection
      eval text
    end

    def component name
      @collection += Component.find(name)
    end
  end
end
