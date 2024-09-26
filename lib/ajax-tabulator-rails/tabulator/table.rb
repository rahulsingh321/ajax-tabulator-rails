module AjaxTabulatorRails
  module Tabulator
    class Table
      attr_reader :table, :options

      def initialize(table)
        @table      = table
        @options   = table.params
      end

      def sortable?
        options[:sort].present?
      end

      def searchable?
        options[:search].present?
      end

      def paginate?
        per_page != -1
      end

      def per_page
        options.fetch(:size, 10).to_i
      end

      def offset
        (page - 1) * per_page
      end

      def page
        options.fetch(:page, 1).to_i
      end
    end
  end
end
