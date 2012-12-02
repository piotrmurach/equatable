# Equatable
[![Build Status](https://secure.travis-ci.org/peter-murach/equatable.png?branch=master)][travis] [![Code Climate](https://codeclimate.com/badge.png)][codeclimate]

[travis]: http://travis-ci.org/peter-murach/equatable
[codeclimate]: https://codeclimate.com/github/peter-murach/equatable

Allows ruby objects to implement equality comparison and inspection methods.

By including this module, a class indicates that its instances have explicit general contracts for `hash`, `==` and `eql?` methods. Specifically `eql?` contract requires that it implements an equivalence relation. By default each instance of the class is equal only to itself. This is a right behaviour when you have distinct objects. Howerver, it is the responsibility of any class to clearly define their equality. Failure to do so may prevent instances to behave as expected when for instance `Array#uniq` is invoked or when they are used as `Hash` keys.

## Installation

Add this line to your application's Gemfile:

    gem 'equatable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install equatable

## Usage

It is assumed that your objects are value objects and the only values that affect equality comparison are the ones specified by your attribute readers. Each attribute reader should be a significant field in determining objects values.

```ruby
  class Value
    include Equatable

    attr_reader :value

    def initialize(value)
      @value = value
    end
  end

  val1 = Value.new(11)
  val2 = Value.new(11)
  val3 = Value.new(13)

  val1 == val2            # => true
  val1.hash == val2.hash  # => true
  val1 eql? val2          # => true

  val1 == val3            # => false
  val1.hash == val3.hash  # => false
  val1 eql? val3          # => false

```

It is important that the attribute readers should allow for performing deterministic computations on class instances.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2012 Piotr Murach. See LICENSE for further details.
