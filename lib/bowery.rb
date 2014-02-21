require 'bowery/version'
require 'bowery/railtie'

module Bowery
  def self.config
    @config ||= ActiveSupport::OrderedOptions.new
  end
end
