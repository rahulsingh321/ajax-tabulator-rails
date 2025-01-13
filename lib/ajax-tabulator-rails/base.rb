module AjaxTabulatorRails
  class Base
    attr_reader :params, :options, :table

    def initialize(params, options = {})
      @params = params
      @options = options
      @table = Tabulator::Table.new(self)
    end

    def view_columns
      raise(NotImplementedError, view_columns_error_text)
    end

    def get_raw_records
      raise(NotImplementedError, raw_records_error_text)
    end

    def data
      raise(NotImplementedError, data_error_text)
    end

    def as_json(*)
      {
        data: sanitize_data(data),
        last_page: calculate_last_page,
        las_row: records_total_count,
        columns: visible_columns
      }
    end

     # send columns to tabulator table which we need to availabe on table
     def visible_columns
      retrieve_visible_columns(options[:columns])
    end

    def field_mappings
      # Default implementation: returns an empty hash
      {}
    end

    def fetch_records
      get_raw_records
    end

    # Main entry point for fetching, filtering, sorting, and paginating records
    def records
      @records ||= retrieve_records
    end

    def retrieve_records
      records = fetch_records
      records = filter_records(records)
      records = sort_records(records) if table.sortable?
      records = paginate_records(records) if table.paginate?
      records
    end

    private

    def sanitize_data(data)
      data.map do |record|
        if record.is_a?(Array)
          record.map { |td| ERB::Util.html_escape(td) }
        else
          record.update(record) { |_, v| ERB::Util.html_escape(v) }
        end
      end
    end

    def retrieve_visible_columns(allowed_columns)
      view_columns_hash = view_columns.index_by { |col| col[:field] }

      if allowed_columns.present?
        allowed_columns.map { |field| view_columns_hash[field] }.compact
      else
        view_columns
      end
    end

    def calculate_last_page
      records_filtered_count / params[:size].to_i
    end

    def records_total_count
      numeric_count fetch_records.count(:all)
    end

    def records_filtered_count
      numeric_count filter_records(fetch_records).count(:all)
    end

    def numeric_count(count)
      count.is_a?(Hash) ? count.values.size : count
    end

    def offset
      offset = (params[:page].to_i - 1) * params[:size].to_i
    end

    def raw_records_error_text
      <<-ERROR

        You should implement this method in your class and specify
        how records are going to be retrieved from the database.
      ERROR
    end

    def data_error_text
      <<-ERROR

        You should implement this method in your class and return an array
        of arrays, or an array of hashes, as defined in the tabulator
        plugin documentation.
      ERROR
    end

    def view_columns_error_text
      <<-ERROR

        You should implement this method in your class and return an array
        of database columns based on the columns displayed in the HTML view.
      ERROR
    end
  end
end