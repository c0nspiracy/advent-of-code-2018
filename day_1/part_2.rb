require 'set'

def find_first_frequency_reached_twice(changes)
  current_frequency = 0
  frequencies_seen = Set.new

  changes.cycle do |change|
    current_frequency += change
    break if frequencies_seen.include?(current_frequency)

    frequencies_seen << current_frequency
  end

  current_frequency
end

changes = File.readlines('input.txt', chomp: true).map(&:to_i)
puts find_first_frequency_reached_twice(changes)
