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
      each { |component| yield component }
    end

    def where options
      select do |component|
        options.keys.reduce(false) do |res,opt|
          res ||= component.send(opt) == options[opt]
        end
      end
    end
  end
end
