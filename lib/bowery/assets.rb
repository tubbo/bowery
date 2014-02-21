module Bowery
  class Assets
    def initialize from_assetfile
      @file = from_assetfile
    end

    def install
      load file
    end
  end
end
