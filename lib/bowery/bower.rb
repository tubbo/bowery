
# Shells out to the Bower executable.

module Bowery
  module Bower
    def bower command, *params
      raise ArgumentError, "Unsupported Bower command '#{command}'." \
        unless respond_to? command

      send command, *params
    end

    private
    def install package, version
      system "bower install #{package} #{version}"
    end
  end
end
