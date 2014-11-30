require 'alephant/logger/version'
require 'logger'

module Alephant
  module Logger
    class Logger
      def initialize(logger)
        @logger = logger
      end

      def method_missing(name, *args, &block)
        message = args[0]
        logger.send(name, message)
      end

      def respond_to?
        logger.respond_to?
      end

      def metric(*args)
      end

      private

      attr_reader :logger
    end

    @@logger = nil

    def logger
     ::Alephant::Logger.get_logger
    end

    def self.get_logger
      @@logger ||= Alephant::Logger::Logger.new ::Logger.new(STDOUT)
    end

    def self.set_logger(value)
      @@logger = Alephant::Logger::Logger.new value
    end
  end
end
