require 'unitwise/rails/validators/compatibility_validator'

module Unitwise
  module Rails
    module Validators
      extend ActiveSupport::Concern

      included do
        extend HelperMethods
        include HelperMethods
      end
    end
  end
end
