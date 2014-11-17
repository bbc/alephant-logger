require 'aws-sdk'

module Alephant
  module Logger
    class Decorator
      def initialize(logger, namespace)
        @logger = logger
        @namespace = namespace

        if namespace
          @cloudwatch = AWS::CloudWatch.new
        end
      end

      # Alephant::Logger.get_logger.info("hi", { :metric => "METRIC", :value => "VALUE", :dimensions => { :foo => :bar, :baz => :quux } })
      def method_missing(name, *args, &block)
        message, metric = args
        logger.send(name, message)

        if log_metric? metric
          put_metric(
            metric.fetch(:metric),
            metric.fetch(:value),
	    metric.fetch(:unit) { "None" },
	    parse_dimensions(metric[:dimensions])
          )
        end
      end

      def respond_to?
        cloudwatch.respond_to? if cloudwatch
      end

      private

      attr_reader :logger, :cloudwatch, :namespace

      def log_metric?(metric)
        cloudwatch && metric
      end

      # maybe rescue AWS exceptions?
      def put_metric(name, value, unit, dimensions)
        cloudwatch.put_metric_data(
          :namespace => namespace,
          :metric_data => [{
              :metric_name => name,
              :value       => value,
              :unit        => unit,
              :dimensions  => dimensions
            }]
          )
      end

      def parse_dimensions(dimensions)
        dimensions.map do |name, value|
          { :name => name, :value => value }
        end
      end
    end
  end
end
