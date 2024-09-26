# AjaxTabulatorRails

**AjaxTabulatorRails** is a lightweight wrapper around Tabulator's Ajax methods, designed to integrate seamlessly with server-side processing in Ruby on Rails applications. It provides an efficient way to handle large datasets by enabling dynamic, server-synced tables with features like sorting, filtering, and pagination.

## Features

- **Seamless Integration**: Syncs Tabulator's front-end functionality with Rails server-side logic.
- **Dynamic Tables**: Supports sorting, filtering, pagination, and inline editing.
- **Efficient Data Handling**: Optimized for large datasets with server-side processing.
- **Customizable**: Easily customize table appearance and behavior through Tabulator's API.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'ajax-tabulator-rails'
```

Then, execute:

```ruby
bundle install
```

Or install it yourself as:

```ruby
gem install ajax-tabulator-rails
```

## Usage
**Setup Tabulator in your Rails views:** Include the necessary Tabulator assets and initialize the table in your JavaScript.

**Server-side Processing:** Use the gem’s helper methods to sync the table with your Rails controllers.

Example of how to initialize Tabulator with Ajax:

```javascript
var table = new Tabulator("#example-table", {
    ajaxURL: "/your_data_endpoint",
    pagination: "remote",
    paginationSize: 10,
    sortMode: "remote",
    filterMode: "remote",
    columns: [
        { title: "ID", field: "id" },
        { title: "Name", field: "name" },
        // other columns
    ]
});
```
In your Rails controller:

```ruby
class DataController < ApplicationController
  def index
    data = YourModel.all
    render json: {
      data: data, # Send the data
      last_page: (data.size / params[:paginationSize].to_i).ceil
    }
  end
end
```

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/rahulsingh321/ajax-tabulator-rails.

## License
The gem is available as open-source under the terms of the MIT License.
