require 'alephant/logger/version'
require 'logger'

module Alephant
  class DelegatingLogger
    attr_reader :logger

    def initialize(logger)
      @logger = logger
    end

    def method_missing(name, *args)
      logger.send(name, *args) if logger.respond_to? name
    end

    def respond_to?(name)
      logger.respond_to? name || super
    end
  end

  module Logger
    @@logger = nil

    def logger
      ::Alephant::Logger.get_logger
    end

    def self.get_logger
      @@logger ||= Alephant::DelegatingLogger.new ::Logger.new(STDOUT)
    end

    def self.set_logger(logger)
      if logger.is_a?(DelegatingLogger)
        @@logger = logger
      else
        @@logger = Alephant::DelegatingLogger.new logger
      end
    end
  end
end
