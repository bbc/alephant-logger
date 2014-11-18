require 'alephant/logger/version'
require 'alephant/logger/decorator'
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
  end
end

