module Unitwise
  module Rails
    module Validators
      class CompatibilityValidator < ActiveModel::EachValidator
        include Unitwise::Rails::Helpers
        def validate_each(record, attribute, value)
          return unless value.is_a?(Unitwise::Measurement)
          return if compatible?(record, value)
          record.errors.add(attribute, :confirmation, attribute: options[:with])
        end

        private

        def check_validity!
          fail ArgumentError, 'You must pass :with option' unless options.key?(:with)
        end

        def compatible?(record, value)
          unit = Unitwise::Unit.new(fetch_option(record, :with))
          value.compatible_with?(unit)
        end
      end

      module HelperMethods
        def validates_unit_compatibility_of(*attributes)
          validates_with CompatibilityValidator,
                         _merge_attributes(attributes)
        end
      end
    end
  end
end
