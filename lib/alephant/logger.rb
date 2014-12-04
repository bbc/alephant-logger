require 'alephant/logger/version'
require 'logger'

module Alephant
  module Logger
    class Logger
      attr_reader :logger

      def initialize(logger)
        @logger = logger
      end

      def method_missing(name, *args, &block)
        logger.send(name, *args)
      end

      def respond_to?(name)
        logger.respond_to?(name)
      end
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
