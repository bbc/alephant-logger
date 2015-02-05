require "alephant/logger/base"

module Alephant
  module LoggerFactory
    def self.create(drivers)
      Alephant::Logger::Base.new drivers
    end
  end
end
