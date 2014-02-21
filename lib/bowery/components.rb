require 'enumerable'

module Bowery
  class Components
    include Enumerable

    def initialize
      @collection = []
    end

    def << component
      @collection << component
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

    def method_missing method, *arguments
      raise NoMethodError unless collection.first.respond_to? method
      each { |component| component.send method, *arguments }
    end

    def as_bower_dependencies
      reduce({}) do |dependencies, asset|
        dependencies.merge "#{asset.name}" => "#{asset.version}"
      end
    end
  end
end
