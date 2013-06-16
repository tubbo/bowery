module Bower
  class InstallGenerator < Rails::Generators::NamedBase
    def generate_assetfile
      copy_file 'Assetfile'
    end

    def generate_bowerrc
      copy_file 'bowerrc', '.bowerrc'
    end
  end
end
