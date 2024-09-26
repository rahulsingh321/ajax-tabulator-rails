# frozen_string_literal: true

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
generators = "#{__dir__}/generators"
loader.ignore(generators)
loader.inflector.inflect(
  'orm'                   => 'ORM',
  'ajax-tabulator-rails' => 'AjaxTabulatorRails'
)
loader.setup

module AjaxTabulatorRails
end
