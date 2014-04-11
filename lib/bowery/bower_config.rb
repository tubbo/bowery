require 'json'
require 'rails'

module Bowery
  # Responsible for writing out the Bower config files.
  class BowerConfig
    include ActiveModel::Model

    attr_accessor :attributes, :components

    def self.write components
      config = new components: components
      config.write
      config
    end

    # Write all Bower config files.
    def write
      File.write "bower.json", contents.to_json
    end

    protected
    def contents
      {
        name: current_folder,
        version: '0.0.1',
        main: '',
        ignore: [
          '.jshintrc',
          '**/*.txt'
        ],
        dependencies: components.to_bower,
        devDependencies: {}
      }
    end

    private
    def current_folder
      File.basename Dir.pwd
    end
  end
end
