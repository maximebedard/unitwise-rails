module Unitwise
  module Rails
    module Validators
      class CompatibilityValidator < UnitValidatorBase
        def validate_each(record, attribute, _value)
          return unless record.send("#{attribute}?")
          return if compatible?(record, attribute)
          record.errors.add(attribute, 'asdasd', options)
        end

        def check_validity!
          return if options.key?(:with)
          fail ArgumentError, 'You must pass in either :with option'
        end

        private

        def compatible?(record, attribute)
          measurement = record.send("#{attribute}")
          unit = Unitwise::Unit.new(options[:with])
          measurement.compatible_with?(unit)
        end
      end

      module HelperMethods
        def validates_unit_compatibility_of(*attributes)
          validates_with CompatibilityValidator, _merge_attributes(attributes)
        end
      end
    end
  end
end
