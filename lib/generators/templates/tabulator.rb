# frozen_string_literal: true

class <%= tabulator_name %> < AjaxTabulatorRails::ActiveRecord
  def view_columns
    @view_columns ||= [
      # Define your columns here
      # Example:
      # { title: 'ID', field: 'id', visible: true, headerSort: true, headerFilter: true, headerFilterFunc: "=" },
      # { title: 'Content', field: 'content', visible: true, headerSort: true, headerFilter: true, headerFilterFunc: "customHeaderFilter", headerFilterPlaceholder: "Search content" }
  ]
  end

  def data
    records.map do |record|
      {
        # Map your data here
      }
    end
  end

  def get_raw_records
    # Define your raw records query here
  end

  # Custom query method used to add a custom query for a particular field where headerFilterFunc: "customHeaderFilter" is set for the column.
  def custom_query(field, value)
    # Implement your custom query logic here
    # Example:
    # where("#{field} = ?", value)
  end
end
