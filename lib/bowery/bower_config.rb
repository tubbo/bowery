require 'json'
require 'rails'

module Bowery
  class BowerConfig
    include ActiveModel::Model

    attr_accessor :attributes, :components

    def self.write components
      config = new components: components
      config.write
      config
    end

    def write
      File.write "bower.json", contents.to_json
    end

    def contents
      #require 'debug'; debugger
      {
        name: 'test',
        version: '0.0.1',
        main: '',
        ignore: [
          '.jshintrc',
          '**/*.txt'
        ],
        dependencies: components,
        devDependencies: {}
      }
    end
  end
end
