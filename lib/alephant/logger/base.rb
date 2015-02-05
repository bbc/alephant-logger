module Alephant
  module Logger
    class Base
      def initialize(drivers)
        @drivers = drivers << ::Logger.new(STDOUT)
      end

      def method_missing(name, *args)
        drivers.each do |driver|
          driver.send(name, *args) if driver.respond_to? name
        end
      end

      def respond_to?(name)
        drivers.any? do |driver|
          driver.respond_to?(name) || super
        end
      end

      private

      attr_reader :drivers
    end
  end
end

