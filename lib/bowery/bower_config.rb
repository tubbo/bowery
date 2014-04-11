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
      write_bower_json and write_bower_rc
    end

    protected
    def write_bower_json
      File.write "bower.json", json_contents.to_json
    end

    def write_bower_rc
      File.write ".bowerrc", rc_contents.to_json
    end

    def json_contents
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

    def rc_contents
      {
        directory: "vendor/components"
      }
    end

    private
    def current_folder
      File.basename Dir.pwd
    end
  end
end
