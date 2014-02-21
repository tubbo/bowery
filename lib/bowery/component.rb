
# Components are created from the `component`, `js`, and `css`
# statements in the Assetfile. They are used to install and update Bower
# packages as well as for writing out manifest files.

module Bowery
  class Component
    include ActiveModel::Model

    attr_accessor :name, :version, :js, :css, :path, :git, :github

    # Install this Component with Bower unless it is being managed with
    # a local path.
    def install
      return if path.present?
      system "bower install #{package} -v=#{version}"
    end

    # Update to the latest version of this Component with Bower unless
    # it is being managed with a local path.
    def update
      return if path.present?
      system "bower update #{package}"
    end

    # Should we include this in the javascripts manifest?
    def js?
      @js || false
    end

    # Should we include this in the stylesheets manifest?
    def css?
      @css || false
    end

    # The package name of this Component, being fetched by Bower.
    def package
      case
      when github.present?
        "https://github.com/#{github}"
      when git.present?
        git
      else
        name
      end
    end
  end
end
