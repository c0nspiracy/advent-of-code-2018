# frozen_string_literal: true

class Point
  attr_reader :x, :y

  def initialize(x, y, dx, dy)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
  end

  def move
    @x += @dx
    @y += @dy
  end
end

class Stars
  attr_reader :elapsed

  def initialize(points)
    @points = points
    @elapsed = 0
  end

  def tick
    @points.each(&:move)
    @elapsed += 1
  end

  def has_vertical_lines?
    groups = @points.group_by(&:x).transform_values do |points|
      points.map(&:y).sort.uniq
    end
    clusters = groups.count do |_x, ys|
      chunk_sizes = ys.chunk_while { |i, j| i + 1 == j }.map(&:size)
      chunk_sizes.any? { |cs| cs >= 8 }
    end
    clusters >= 3
  end

  def display
    min_x, max_x = @points.minmax_by(&:x).map(&:x)
    min_y, max_y = @points.minmax_by(&:y).map(&:y)
    positions = @points.map { |point| [[point.y, point.x], true] }.to_h
    (min_y..max_y).each do |y|
      line = (min_x..max_x).map do |x|
        positions[[y, x]] ? "#" : "."
      end
      puts line.join
    end
    puts
    nil
  end
end

points = []
input = ARGF.readlines(chomp: true)
points = input.map do |line|
  line.match(/\Aposition=<\s*(-?\d+),\s*(-?\d+)> velocity=<\s*(-?\d+),\s*(-?\d+)>\z/) do |match_data|
    Point.new(*match_data.captures.map(&:to_i))
  end
end

stars = Stars.new(points)
stars.tick until stars.has_vertical_lines?

puts "Part 1:"
stars.display

puts "Part 2: #{stars.elapsed}"
