module Unitwise
  module Rails
    module Validators
      class PresenceValidator < UnitValidatorBase
        def validate_each(record, attribute, _value)
          return if record.send("#{attribute}?")
          record.errors.add(attribute, :present, options)
        end
      end

      module HelperMethods
        def validates_unit_presence(*attributes)
          validates_with PresenceValidator, _merge_attributes(attributes)
        end
      end
    end
  end
end
