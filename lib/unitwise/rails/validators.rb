require 'unitwise/rails/validators/unit_validator_base'
require 'unitwise/rails/validators/presence_validator'
require 'unitwise/rails/validators/compatibility_validator'

module Unitwise
  module Rails
    module Validators
      extend ActiveSupport::Concern

      included do
        extend HelperMethods
        include HelperMethods
      end

      module ClassMethods
        def validates_unit(*attributes)
        end
      end
    end
  end
end
