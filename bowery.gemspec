$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bowery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name        = "bowery"
  gem.version     = Bowery::VERSION
  gem.authors     = ["Tom Scott"]
  gem.email       = ["tubbo@psychedeli.ca"]
  gem.homepage    = "http://github.com/tubbo/bowery"
  gem.summary     = "The missing asset manager for Rails"
  gem.description = gem.summary

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails"
  gem.add_dependency 'thor'

  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
end
