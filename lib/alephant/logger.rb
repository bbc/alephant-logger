require "alephant/logger/version"
require "alephant/logger_factory"
require "logger"

module Alephant
  module Logger
    @@logger = Alephant::LoggerFactory.create

    def logger
      @@logger
    end

    def self.setup(*drivers)
      @@logger = Alephant::LoggerFactory.create(drivers.flatten)
    end
  end
end
