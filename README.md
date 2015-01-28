# Alephant::Logger

Logger functionality for BBC News' [Alephant](https://github.com/BBC-News/alephant) framework.

[![Build
Status](https://travis-ci.org/BBC-News/alephant-logger.png)](https://travis-ci.org/BBC-News/alephant-logger) [![Gem Version](https://badge.fury.io/rb/alephant-logger.png)](http://badge.fury.io/rb/alephant-logger)

## Installation

Add this line to your application's Gemfile:

    gem 'alephant-logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alephant-logger

## Usage

```rb
require 'alephant/logger'

# Using the standard logger
class IncludesLogger
  include Alephant::Logger

  def calls_logger
    logger.warn "MUCH WARN. WOW."
  end
end

# Sets a logger
class SetsLogger
  include Alephant::Logger

  def calls_logger
    Alephant::Logger.set_logger(CustomLogger.new)
    logger.warn "SUCH CUSTOM. MUCH LOG."
  end
end
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
