module Unitwise
  module Rails
    module Validators
      class UnitCompatibilityValidator < UnitValidatorBase
        def validate_each(record, attribute, _value)
          return unless record.send("#{attribute}?")
          return if compatible?(record, attribute)
          record.errors.add(attribute, :confirmation, attribute: options[:with])
        end

        def check_validity!
          return if options.key?(:with)
          fail ArgumentError, 'You must pass in either :with option'
        end

        private

        def compatible?(record, attribute)
          measurement = record.send("#{attribute}")
          unit = Unitwise::Unit.new(with_option(record))
          measurement.compatible_with?(unit)
        end

        def with_option(record)
          return record.send(options[:with]) if record.respond_to?(options[:with])
          options[:with]
        end
      end

      module HelperMethods
        def validates_unit_compatibility_of(*attributes)
          validates_with UnitCompatibilityValidator, _merge_attributes(attributes)
        end
      end
    end
  end
end
