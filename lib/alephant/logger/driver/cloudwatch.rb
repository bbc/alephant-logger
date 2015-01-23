require "aws-sdk"

module Alephant
  module Logger
    module Driver
      class CloudWatch
        def initialize(namespace)
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
          end
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
end
