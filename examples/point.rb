# frozen_string_literal: true

require_relative "../lib/equatable"

# A point on a Cartesian plane
class Point
  include Equatable

  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end
end

# A coloured point on a Cartesian plane
class ColorPoint < Point
  attr_reader :color

  def initialize(x, y, color)
    super(x, y)
    @color = color
  end
end

point1 = Point.new(1, 1)
point2 = Point.new(1, 1)
point3 = Point.new(2, 1)

puts "** Comparison with equal **"
puts "Point.new(1,1) == Point.new(1,1): #{point1 == point2}"
puts "Point.new(1,1).hash == Point.new(1,1).hash: #{point1.hash == point2.hash}"
puts "Point.new(1,1).eql?(Point.new(1,1)): #{point1.eql?(point2)}"
puts "Point.new(1,1).equal?(Point.new(1,1)): #{point1.equal?(point2)}"

puts "\n** Comparison with unequal **"
puts "Point.new(1,1) == Point.new(2,1): #{point1 == point3}"
puts "Point.new(1,1).hash == Point.new(2,1).hash: #{point1.hash == point3.hash}"
puts "Point.new(1,1).eql?(Point.new(2,1)): #{point1.eql?(point3)}"
puts "Point.new(1,1).equal?(Point.new(2,1)): #{point1.equal?(point3)}"

point = Point.new(1, 1)
color_point = ColorPoint.new(1, 1, :red)

puts "\n** Comparison with subtype **"
puts "Point.new(1,1) == ColorPoint.new(1,1,:red): #{point == color_point}"
puts "ColorPoint.new(1,1,:red) == Point.new(1,1): #{color_point == point}"
puts "Point.new(1,1).hash == ColorPoint.new(1,1,:red).hash: #{point.hash == color_point.hash}"
puts "Point.new(1,1).eql?(ColorPoint.new(1,1,:red)): #{point.eql?(color_point)}"
puts "Point.new(1,1).equal?(ColorPoint.new(1,1,:red)): #{point.equal?(color_point)}"

puts "\n** Inspect **"
puts "Point.new(1,1).inspect: #{point1.inspect}"
