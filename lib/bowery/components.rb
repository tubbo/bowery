module Bowery
  class Components
    include Enumerable

    attr_reader :collection

    def initialize
      @collection = []
    end

    def << component
      @collection << component
    end

    def each
      @collection.each { |component| yield component }
    end

    def where options
      select do |component|
        options.keys.reduce(false) do |res,opt|
          res ||= component.send(opt) == options[opt]
        end
      end
    end

    def to_bower
      reduce({}) do |bower_dependencies, component|
        bower_dependencies.merge component.name => "#{component.version}"
      end
    end
  end
end
