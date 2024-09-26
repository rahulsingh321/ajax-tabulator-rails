# frozen_string_literal: true

require 'rails/generators'

module Rails
  module Generators
    class TabulatorGenerator < ::Rails::Generators::Base
      desc 'Creates a *_table model in the app/tabulator directory.'
      source_root File.expand_path('templates', __dir__)
      argument :name, type: :string

      def generate_tabulator
        template 'tabulator.rb', File.join('app', 'tabulator', "#{tabulator_path}.rb")
      end

      def tabulator_name
        tabulator_path.classify
      end

      private

      def tabulator_path
        "#{name.underscore}_table"
      end
    end
  end
end
