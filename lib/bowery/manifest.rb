# A JS or CSS manifest for Sprockets.

module Bowery
  class Manifest
    def initialize for_type, and_assets, and_options
      @type = for_type
      @assets = and_assets
      @name = and_options[:name]
      @path_prefix = and_options[:path]
    end

    def path
      @path ||= "#{@path_prefix}/#{@name}.#{extension}"
    end

    def extension
      @extension ||= case @type
      when 'javascripts'
        'js'
      when 'stylesheets'
        'css'
      else
        'txt'
      end
    end

    def save
      File.open path, 'rw+' do |manifest_file|
        manifest_file.puts contents
      end
    end

    def contents
      @file_contents ||= if type == 'javascripts'
        requires
      else
        %{
        /*
         #{requires}
         */
        }
      end
    end

    protected
    def requires
      @requires = relevant_assets.reduce("") do |reqs,asset|
        reqs += "#{require_prefix} #{asset.name}"
      end
    end

    private
    def require_prefix
      if type == 'stylesheets'
        "*="
      else
        "//="
      end
    end

    def relevant_assets
      assets.send type
    end
  end
end
