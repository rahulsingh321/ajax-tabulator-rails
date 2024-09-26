# my_gem_name.gemspec
require_relative 'lib/ajax-tabulator-rails/version'

Gem::Specification.new do |s|
  s.name        = "ajax-tabulator-rails"
  s.version     = AjaxTabulatorRails::VERSION::STRING
  s.authors     = ["Rahul Singh"]
  s.email       = ["rahul97811@gmail.com"]
  s.summary     = "A wrapper around Tabulator's ajax methods that allow synchronisation with server-side operations in a Rails app"
  s.description = "A lightweight wrapper around Tabulator's Ajax methods, designed to enable seamless synchronization with server-side processing in Rails applications. It simplifies managing data tables by integrating Tabulator's dynamic features like pagination, sorting, and filtering, while keeping the server-side logic in sync for efficient handling of large datasets."
  s.homepage    = "https://github.com/rahulsingh321/ajax-tabulator-rails"
  s.license     = "MIT"

  s.files       = Dir["lib/**/*"] # Automatically include all files in lib
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rails', '>= 7.0'
  s.add_runtime_dependency 'zeitwerk'

  s.add_development_dependency 'rubocop'
end
