module Bowery
  class ManifestGenerator < Rails::Generators::Base
    def generate_manifest
      template 'manifest.js', 'app/assets/application.js'
    end

  protected
    def components
      Librarian::Bower::Manifest.new.components
    end
  end
end
