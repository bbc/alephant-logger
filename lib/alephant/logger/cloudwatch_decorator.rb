require "aws-sdk"

module Alephant
  module Logger
    class CloudWatchDecorator
      def initialize(logger, namespace)
        @logger = logger
        @namespace = namespace
        @cloudwatch = AWS::CloudWatch.new
      end

      def metric(opts)
        name, value, unit, dimensions = opts.values_at(:name, :value, :unit, :dimensions)

        cloudwatch.put_metric_data(
          :namespace => namespace,
          :metric_data => [{
            :metric_name => name,
            :value       => determine(name, value),
            :unit        => unit || "None",
            :dimensions  => parse(dimensions || {})
          }]
        )
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

      def determine(name, value)
        value ? value : increment_metric_value(name)
      end

      def increment_metric_value(name)
        stats = get_stats name
        stats.nil? ? 0 : stats.last[:sum] += 1
      end

      def get_stats(name)
        sort(filter_metric name)
      end

      def filter_metric(name)
        filter_namespace.filter("metric_name", name)
      end

      def filter_namespace
        cloudwatch.metrics.filter("namespace", namespace)
      end

      def sort(metric)
        stats = stats_for(metric)
        stats.sort do |a, b|
          a[:timestamp] <=> b[:timestamp]
        end unless stats.datapoints.size == 0
      end

      def stats_for(metric)
        metric.first.statistics({
          :statistics => ["Sum"],
          :start_time => Time.now - 3600, # one hour ago
          :end_time => Time.now
        })
      end
    end
  end
end
