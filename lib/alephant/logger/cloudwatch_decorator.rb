require 'aws-sdk'

module Alephant
  module Logger
    class CloudWatchDecorator
      def initialize(logger, namespace)
        @logger = logger
        @namespace = namespace
        @cloudwatch = AWS::CloudWatch.new
      end

      def metric(hash)
        put_metric(
          hash.fetch(:name),
          hash.fetch(:value),
          hash.fetch(:unit) { "None" },
          parse_dimensions(hash.fetch(:dimensions) { {} })
        )
      end

      def method_missing(name, *args)
        logger.send(name, *args)
      end

      def respond_to?(name)
        logger.respond_to?(name) || super
      end

      private

      attr_reader :logger, :cloudwatch, :namespace

      def put_metric(name, value, unit, dimensions)
        cloudwatch.put_metric_data(
          :namespace => namespace,
          :metric_data => [{
            :metric_name => name,
            :value       => value,
            :unit        => unit
          }]
        )
      end

      def parse_dimensions(dimensions={})
        dimensions.map do |name, value|
          { :name => name, :value => value }
        end
      end
    end
  end
end
