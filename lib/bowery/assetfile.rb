
# Helper methods for the Assetfile.

module Bowery
  module Assetfile
    def js name, version, options={}
      component name, version, options.merge(js: true)
    end

    def css name, version, options={}
      component name, version, options.merge(css: true)
    end

    def component name, version, options={}
      attributes = options.merge name: name, version: version
      components << Component.new(attributes)
    end

    private
    def components
      @components ||= Components.new
    end
  end
end
