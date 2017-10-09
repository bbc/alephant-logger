require "alephant/logger/version"
require "alephant/logger_factory"
require "logger"

module Alephant
  module Logger
    def logger
      Logger.verify_logger_created
      @@logger
    end

    def self.get_logger
      verify_logger_created
      @@logger
    end

    def self.setup(*drivers)
      @@logger = Alephant::LoggerFactory.create(drivers.flatten)
    end

    def self.verify_logger_created
      Alephant::Logger.setup unless defined? @@logger
    end
  end
end
