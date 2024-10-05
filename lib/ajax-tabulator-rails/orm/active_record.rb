module AjaxTabulatorRails
  module ORM
    module ActiveRecord
      TYPE_CAST_DEFAULT = 'VARCHAR'.freeze

      def filter_records(records)
        filter_conditions = build_filter_conditions(records)
        global_search_condition = build_global_search_condition(records)

        if filter_conditions && global_search_condition
          records.where("#{filter_conditions} AND (#{global_search_condition})")
        elsif filter_conditions
          records.where(filter_conditions)
        elsif global_search_condition
          records.where(global_search_condition)
        else
          records
        end
      end

      def sort_records(records)
        sort_params = params[:sort] || {}
        sort_conditions = []

        sort_params.each do |_, sort|
          field = sort['field']
          direction = sort['dir'] || 'asc'

          backend_field = field_mappings[field] || field
          if field.present? && %w[asc desc].include?(direction)
            sort_conditions << "#{backend_field} #{direction}"
          end
        end
        records.order(sort_conditions.join(', '))
      end

      def paginate_records(records)
        records.offset(table.offset).limit(table.per_page)
      end

      def build_filter_conditions(records)
        filter_params = params.dig(:filter)
        return nil unless filter_params.present?

        conditions = []
        filter_params.each do |_, filter|
          field = filter['field']
          value = filter['value']
          type = filter['type']

          backend_field = field_mappings[field] || field
          conditions << build_condition_for_field(backend_field, type, value)
        end

        conditions.compact.join(' AND ')
      end

      def build_condition_for_field(backend_field, type, value)
        return nil unless value.present?

        sanitized_value = sanitize_sql(value)

        case type
        when "function"
          custom_condition = custom_query(backend_field, value)
          custom_condition if custom_condition.present?
        when "=", "!=", "<", ">", "<=", ">="
          build_comparison_condition(backend_field, type, sanitized_value)
        when 'in'
          values = value.split(',').map { |v| "'#{sanitize_sql(v)}'" }.join(', ')
          "#{backend_field} IN (#{values})" if value.present?
        when 'starts'
          "#{backend_field} ILIKE '#{sanitized_value}%'" if value.present?
        when 'ends'
          "#{backend_field} ILIKE '%#{sanitized_value}'" if value.present?
        when 'like'
          "#{backend_field} ILIKE '%#{sanitized_value}%'" if value.present?
        when 'regex'
          "#{backend_field} ~ '#{sanitized_value}'" if value.present?
        else
          raise ArgumentError, "Unknown filter type: #{type}"
        end
      end

      def build_comparison_condition(field, operator, value)
        "#{field} #{operator} '#{value}'"
      end

      def build_global_search_condition(records)
        search_value = params.dig(:search)
        return nil unless search_value.present?

        escaped_search_value = escape_like_query(search_value)

        conditions = searchable_columns.map do |column|
          field = field_mappings[column[:field]] || column[:field]

          if field.include?('.')
            # For associated table columns
            "CAST(#{field} AS #{TYPE_CAST_DEFAULT}) ILIKE '%#{escaped_search_value}%'"
          else
            # For direct columns
            "CAST(#{records.arel_table[field].name} AS #{TYPE_CAST_DEFAULT}) ILIKE '%#{escaped_search_value}%'"
          end

        end
        conditions.join(' OR ')
      end

      def sanitize_sql(value)
        ::ActiveRecord::Base.sanitize_sql(value)
      end

      def searchable_columns
        view_columns.select { |column| column[:field].present? }
      end

      def escape_like_query(value)
        sanitized_value = ::ActiveRecord::Base.connection.quote_string(value)
        ::ActiveRecord::Base.sanitize_sql_like(sanitized_value)
      end
    end
  end
end
