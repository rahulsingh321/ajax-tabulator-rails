# my_gem_name.gemspec
require_relative 'lib/ajax-tabulator-rails/version'

Gem::Specification.new do |s|
  s.name        = "ajax-tabulator-rails"
  s.version     = AjaxTabulatorRails::VERSION::STRING
  s.authors     = ["Your Name"]
  s.email       = ["you@example.com"]
  s.summary     = "A short summary of your gem"
  s.description = "A longer description of your gem"
  s.homepage    = "https://github.com/your_username/my_gem_name"
  s.license     = "MIT"

  s.files       = Dir["lib/**/*"] # Automatically include all files in lib
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rails', '>= 7.0'
  s.add_runtime_dependency 'zeitwerk' 

  s.add_development_dependency 'rubocop'
end
