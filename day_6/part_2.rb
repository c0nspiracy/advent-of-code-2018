require 'set'

def manhattan_distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

coords = ARGF.readlines(chomp: true).map { |line| line.split(", ").map(&:to_i) }
max = coords.flatten.max
grid = Array.new(max + 1) { Array.new(max + 1, 0) }

region = []
grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    manhattan_sum = coords.sum { |x2, y2| manhattan_distance(x, y, x2, y2) }
    region << [y, x] if manhattan_sum < 10_000
  end
end

puts region.count
