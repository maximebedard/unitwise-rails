module Unitwise
  module Rails
    module Helpers
      def fetch_option(record, name) # sketchy
        option = options[name]
        if option.respond_to?(:call)
          option.call
        elsif record.respond_to?(option)
          record.send(option)
        else
          option
        end
      end
    end
  end
end
