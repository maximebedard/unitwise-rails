module Unitwise
  module Rails
    # Provides helper methods that can be used in migrations.
    module Migration
      extend ActiveSupport::Concern

      COLUMNS = {
        value: :decimal,
        unit: :string
      }

      included do
        ActiveRecord::ConnectionAdapters::Table.send :include, TableDefinition
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, TableDefinition
        ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, Statements
        ActiveRecord::Migration::CommandRecorder.send :include, CommandRecorder
      end

      module Statements
        def add_unit(table_name, *unit_names)
          fail ArgumentError, 'Please specify attachment name in your add_unit call in your migration.' if unit_names.empty?

          options = unit_names.extract_options!

          unit_names.each do |unit_name|
            COLUMNS.each_pair do |column_name, column_type|
              column_options = options.merge(options[column_name.to_sym] || {})
              add_column(table_name, "#{unit_name}_#{column_name}", column_type, column_options)
            end
          end
        end

        def remove_unit(table_name, *unit_names)
          fail ArgumentError, 'Please specify attachment name in your remove_unit call in your migration.' if unit_names.empty?

          options = unit_names.extract_options!

          unit_names.each do |unit_name|
            COLUMNS.each_pair do |column_name, column_type|
              column_options = options.merge(options[column_name.to_sym] || {})
              remove_column(table_name, "#{unit_name}_#{column_name}", column_type, column_options)
            end
          end
        end
      end

      module TableDefinition
        def unit(*unit_names)
          options = unit_names.extract_options!
          unit_names.each do |unit_name|
            COLUMNS.each_pair do |column_name, column_type|
              column_options = options.merge(options[column_name.to_sym] || {})
              column("#{unit_name}_#{column_name}", column_type, column_options)
            end
          end
        end
      end

      module CommandRecorder
        def add_unit(*args)
          record(:add_unit, args)
        end

        private

        def invert_add_unit(args)
          [:remove_unit, args]
        end
      end
    end
  end
end
