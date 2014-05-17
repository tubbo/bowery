require 'bowery/components'
require 'bowery/component'

# The Componentfile DSL. These methods are mixed in and used by the
# Componentfile to build the `components` collection used to actually
# install Bower assets. These methods create Component classes, and are
# shoveled into the big collection.

module Bowery
  module Componentfile
    # Specify an alternative API other than the official Bower registry.
    def source api
      return if api == :bower
    end

    # Specify a javascript component to install.
    def js name, version='', options={}
      component name, version, options.merge(js: true)
    end

    # Specify a stylesheet component to install.
    def css name, version='', options={}
      component name, version, options.merge(css: true)
    end

    # Specify an open-ended component to install. Useful for components
    # with both JS and CSS assets, or neither.
    def component name, version='', options={}
      attributes = options.merge name: name, version: version
      components << Component.new(attributes)
    end

    private
    def components
      @components ||= Components.new
    end
  end
end
