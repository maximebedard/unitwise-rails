module Unitwise
  module Rails
    module Validators
      class UnitCompatibilityValidator < ActiveModel::EachValidator
        include Unitwise::Rails::Helpers

        def validate_each(record, attribute, _value)
          check_unit_validity!(record, attribute)
          return unless record.send("#{attribute}?")
          return if compatible?(record, attribute)
          record.errors.add(attribute, :confirmation, attribute: options[:with])
        end

        private

        def check_validity!
          return if options.key? :with
          fail ArgumentError, 'You must pass in either :with option'
        end

        def check_unit_validity!(record, attribute)
          attributes = ["#{attribute}_value", "#{attribute}_unit"]
          return if attributes.all? { |attr| record.has_attribute?(attr) }

          fail ArgumentError, "Attribute #{attribute} is not a unit. " \
                              "Add `unit_for :#{attribute}` to #{record.class}."
        end

        def compatible?(record, attribute)
          measurement = record.send("#{attribute}")
          unit = Unitwise::Unit.new(eval_option(options[:with], record))
          measurement.compatible_with?(unit)
        end
      end

      module HelperMethods
        def validates_unit_compatibility_of(*attributes)
          validates_with UnitCompatibilityValidator,
                         _merge_attributes(attributes)
        end
      end
    end
  end
end
