require "alephant/logger/version"
require "alephant/logger_factory"
require "logger"

module Alephant
  module Logger
    def logger
      Alephant::Logger.setup unless defined? @@logger

      @@logger
    end

    def self.get_logger
      Alephant::Logger.setup unless defined? @@logger

      @@logger
    end

    def self.setup(*drivers)
      @@logger = Alephant::LoggerFactory.create(drivers.flatten)
    end
  end
end
