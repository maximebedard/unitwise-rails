module Unitwise
  module Rails
    module Helpers
      def eval_option(option, record)
        case option
        when Symbol
          return record.send option if record.respond_to?(option)
        end
        option
      end
    end
  end
end
