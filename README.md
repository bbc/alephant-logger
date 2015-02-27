# Alephant::Logger

Logger functionality for BBC News' [Alephant](https://github.com/BBC-News/alephant) framework.

[![Build
Status](https://travis-ci.org/BBC-News/alephant-logger.png)](https://travis-ci.org/BBC-News/alephant-logger) [![Gem Version](https://badge.fury.io/rb/alephant-logger.png)](http://badge.fury.io/rb/alephant-logger)

## Installation

Add this line to your application's Gemfile:

```
gem 'alephant-logger'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install alephant-logger
```

In addition to this, you may want to install one of the supported Alephant logger drivers:
* [alephant-logger-statsd](https://github.com/BBC-News/alephant-logger-statsd)
* [alephant-logger-cloudwatch](https://github.com/BBC-News/alephant-logger-cloudwatch)

## Usage

```rb
require "alephant/logger"
require "alephant/logger/statsd"
require "alephant/logger/cloudwatch"

config = {
  :host      => "statsd.test.service.bbc.co.uk",
  :port      => 6452,
  :namespace => "test"
}

statsd_driver     = Alephant::Logger::Statsd.new config
cloudwatch_driver = Alephant::Logger::CloudWatch.new "my_namespace"

logger = Alephant::Logger.setup([statsd_driver, cloudwatch_driver])
logger.increment "foo.bar"
logger.metric(:name => "FooBar", :unit => "Count", :value => 1)
```

## Drivers

You can consume an array of other gems to allow Alephant Logger to send custom metrics:

1. [Statsd](https://github.com/BBC-News/alephant-logger-statsd#alephantloggerstatsd)

## Contributing

1. [Fork it!](http://github.com/BBC-News/alephant-logger/fork)
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Create new [Pull Request](https://github.com/BBC-News/alephant-logger/compare).
