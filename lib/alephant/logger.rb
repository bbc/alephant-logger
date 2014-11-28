require 'alephant/logger/version'
require 'logger'

module Alephant
  module Logger
    @@logger = nil

    def logger
      ::Alephant::Logger.get_logger
    end

    def self.get_logger
      @@logger ||= ::Logger.new(STDOUT)
    end

    def self.set_logger(value)
      @@logger = value
    end

    def method_missing(name, *args, &block)
      message = args[0]
      logger.send(name, message)
    end

    def respond_to?
      cloudwatch.respond_to?
    end

    def metric
    end
  end
end

