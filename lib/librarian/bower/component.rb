module Librarian
  module Bower
    class Component
      def self.where filters={}
        results = assets.components.select do |component|
          filters.reduce true do |result,filter|
            if component.responds_to? filter
              result || component.send(filter)
            else
              result
            end
          end
        end

        if results.count > 1
          results
        else
          results.first
        end
      end

      def initialize with_attributes={}
      end

    private
      def self.assets
        @assets ||= Bowery::Assetfile.new
      end
    end
  end
end
