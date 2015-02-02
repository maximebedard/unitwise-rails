module Unitwise
  module Rails
    module Validators
      class UnitValidatorBase < ActiveModel::EachValidator
        def validate(record)
          attributes.each { |attr| check_unit_validity!(attr, record) }
          super
        end

        private

        def check_unit_validity!(attribute, record)
          attributes = ["#{attribute}_value", "#{attribute}_unit"]
          return if attributes.all? { |attr| record.has_attribute?(attr) }

          fail ArgumentError, "Attribute #{attribute} is not a unit. " \
          "Add `unit_for :#{attribute}` to #{record.class}."
        end
      end
    end
  end
end
