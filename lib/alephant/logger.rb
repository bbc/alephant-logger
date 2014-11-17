require 'alephant/logger/version'
require 'alephant/logger/decorator'
require 'logger'

module Alephant
  module Logger
    @@logger = nil

    def logger
      ::Alephant::Logger.get_logger
    end

    def self.get_logger(namespace=nil)
      @@logger ||= Decorator.new(::Logger.new(STDOUT), namespace)
    end

    def self.set_logger(value)
      @@logger = value
    end
  end
end

