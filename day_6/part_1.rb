require 'set'

def manhattan_distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

coords = File.readlines('input.txt', chomp: true).map { |line| line.split(", ").map(&:to_i) }

max = coords.flatten.max
grid = Array.new(max + 1) { Array.new(max + 1, 0) }
coords.each.with_index(1) { |(x, y), i| grid[y][x] = -i }

grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    next unless cell.zero?

    distances = coords.map { |x2, y2| [x2, y2, manhattan_distance(x, y, x2, y2)] }
    *closest_coords, closest_distance = distances.min_by(&:last)
    if distances.map(&:last).count(closest_distance) == 1
      grid[y][x] = coords.index(closest_coords) + 1
    end
  end
end

t_grid = grid.transpose
ignored = Set.new
ignored.merge(grid.first)
ignored.merge(grid.last)
ignored.merge(t_grid.first)
ignored.merge(t_grid.last)
ignored.select!(&:positive?)

considered = 1.upto(coords.size).to_a - ignored.to_a

f_grid = grid.flatten
puts considered.map { |i| f_grid.count(i) }.max + 1
