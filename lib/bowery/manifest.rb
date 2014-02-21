# A JS or CSS manifest for Sprockets.

module Bowery
  class Manifest
    include ActiveModel::Model

    attr_accessor :name, :path, :type, :components

    validates :name, presence: true
    validates :path, presence: true
    validates :type, presence: true
    validates :components, presence: true

    def absolute_path
      @abs_path ||= "#{path}/#{type}/#{name}.#{extension}"
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
      @requires = relevant_components.reduce("") do |reqs,asset|
        reqs += "#{require_prefix} #{asset.name}"
      end
    end

    private
    def require_prefix
      case type
      when 'stylesheets'
        "*="
      when 'javascripts'
        "//="
      else
        ""
      end
    end

    def relevant_components
      components.where extension => true
    end
  end
end
