module Unitwise
  module Rails
    module UnitFor
      extend ActiveSupport::Concern

      included do
      end

      module ClassMethods
        def unit_for(*attributes, **options)
          attributes.each do |attrib|
            UnitForImpl.define_on(self, attrib, options)
            units[attrib] = options
          end
        end

        def units
          @units ||= {}
        end
      end
    end

    class UnitForImpl
      include Unitwise::Rails::Helpers
      def self.define_on(klass, name, **options)
        new(klass, name, options).define
      end

      def initialize(klass, name, **options)
        @klass = klass
        @name = name
        @options = options
      end

      attr_reader :klass, :name, :options

      def define
        define_getter
        define_setter
        define_query
        define_callback
      end

      private

      # Returns true if the :attr_value and
      # :attr_unit are present
      def define_query
        name = @name
        klass.send :define_method, "#{name}?" do
          send("#{name}_value").present? &&
            send("#{name}_unit").present?
        end
      end

      # Returns a Unitwise::Mesurement builded
      # from fields :attr_value and :attr_unit
      def define_getter
        name = @name
        klass.send :define_method, "#{name}" do
          return unless send("#{name}?")
          Unitwise(send("#{name}_value"), send("#{name}_unit"))
        end
      end

      # Sets :attr_value and :attr_unit from the
      # Unitwise::Mesurement
      def define_setter
        name = @name
        klass.send :define_method, "#{name}=" do |unit|
          send "#{name}_value=", unit.value
          send "#{name}_unit=", unit.unit.to_s
        end
      end

      def define_callback
        return unless @options.key? :convert_to
        name = @name
        convert_to_option = fetch_option(klass, :convert_to)
        klass.send :before_save do
          next unless send("#{name}?")
          send("#{name}=", send(name).convert_to(convert_to_option))
        end
      end
    end
  end
end
