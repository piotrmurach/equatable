# Equatable

[![Gem Version](https://badge.fury.io/rb/equatable.svg)][gem]
[![Actions CI](https://github.com/piotrmurach/equatable/workflows/CI/badge.svg?branch=master)][gh_actions_ci]
[![Build status](https://ci.appveyor.com/api/projects/status/lsb02nm0g4c6guiu?svg=true)][appveyor]
[![Code Climate](https://codeclimate.com/github/piotrmurach/equatable/badges/gpa.svg)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/equatable/badge.svg)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/equatable.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/equatable
[gh_actions_ci]: https://github.com/piotrmurach/equatable/actions?query=workflow%3ACI
[appveyor]: https://ci.appveyor.com/project/piotrmurach/equatable
[codeclimate]: https://codeclimate.com/github/piotrmurach/equatable
[coverage]: https://coveralls.io/github/piotrmurach/equatable
[inchpages]: http://inch-ci.org/github/piotrmurach/equatable

> Provide equality comparison methods for objects based on their attributes.

By including this module, a class indicates that its instances have explicit general contracts for `==`, `eql?` and `hash` methods. Specifically the `eql?` contract requires that it implements an equivalence relation. By default, each instance of a class is equal only to itself. This is the right behaviour when you have distinct objects. However, it is the responsibility of any class to clearly define its equality. Failure to do so may prevent instances from behaving as expected when tested for uniqueness in Array#uniq or when used as Hash keys.

## Installation

Add this line to your application's Gemfile:

    gem "equatable"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install equatable

## Usage

It is assumed that your objects are value objects and the only values that affect equality comparison are the ones specified by your attribute readers. Each attribute reader should be a significant field in determining objects values.

```ruby
class Point
  include Equatable

  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end
end

point_1 = Point.new(1, 1)
point_2 = Point.new(1, 1)
point_3 = Point.new(1, 2)

point_1 == point_2            # => true
point_1.hash == point_2.hash  # => true
point_1.eql?(point_2)         # => true
point_1.equal?(point_2)       # => false

point_1 == point_3            # => false
point_1.hash == point_3.hash  # => false
point_1.eql?(point_3)         # => false
point_1.equal?(point_3)       # => false

point_1.inspect  # => "#<Point x=1 y=1>"
```

## Attributes

It is important that the attribute readers should allow for performing deterministic computations on class instances. Therefore you should avoid specifying attributes that depend on unreliable resources like IP address that require network access.

## Subtypes

**Equatable** ensures that any important property of a type holds for its subtypes. However, please note that adding an extra attribute reader to a subclass will violate the equivalence contract, namely, the superclass will be equal to the subclass but reverse won't be true. For example:

```ruby
class ColorPoint < Point
  attr_reader :color

  def initialize(x, y, color)
    super(x, y)
    @color = color
  end
end

point = Point.new(1, 1)
color_point = ColorPoint.new(1, 1, :red)

point == color_point            # => true
color_point == point            # => false

point.hash == color_point.hash  # => false
point.eql?(color_point)         # => false
point.equal?(color_point)       # => false
```

The `ColorPoint` class demonstrates that extending a class with extra value property does not preserve the `equals` contract.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Code of Conduct

Everyone interacting in the Equatable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/equatable/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2012 Piotr Murach. See LICENSE for further details.
