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
        # content: record.content
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

  # Defines mappings for fields that pull data from associated tables.
  # This is useful when you want to display data from associations in
  # the Tabulator columns, such as fields from `comments` or `tags` tables.
  def field_mappings
    {
    #   'comments_message' => 'comments.message',  Maps to the message field from comments table
    #   'tags_name' => 'tags.name',                Maps to the name field from the tags table
    #   'id' => 'posts.id',                        Maps to the ID field from the posts table
    #   'created_at' => 'posts.created_at'         Maps to the created_at field from the posts table
    }
  end
end
