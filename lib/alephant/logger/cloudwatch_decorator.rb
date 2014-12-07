require "aws-sdk"

module Alephant
  module Logger
    class CloudWatchDecorator
      ONE_HOUR = 3600

      def initialize(logger, namespace)
        @logger = logger
        @namespace = namespace
        @cloudwatch = AWS::CloudWatch.new
      end

      def metric(opts)
        name, value, unit, dimensions = opts.values_at(:name, :value, :unit, :dimensions)

        Thread.new do
          cloudwatch.put_metric_data(
            :namespace => namespace,
            :metric_data => [{
              :metric_name => name,
              :value       => value,
              :unit        => unit || "None",
              :dimensions  => parse(dimensions || {})
            }]
          )
        end.join
      end

      # Ruby's Kernel implements a `warn` method
      def warn(*args)
        logger.warn(*args)
      end

      def method_missing(name, *args)
        logger.send(name, *args)
      end

      def respond_to?(name)
        logger.respond_to?(name) || super
      end

      private

      attr_reader :logger, :cloudwatch, :namespace

      def parse(dimensions)
        dimensions.map do |name, value|
          {
            :name  => name,
            :value => value
          }
        end
      end
    end
  end
end
