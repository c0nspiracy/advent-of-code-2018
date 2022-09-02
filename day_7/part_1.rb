# frozen_string_literal: true

require "set"

step_order = Hash.new { |h, k| h[k] = [] }
steps = Set.new

instructions = ARGF.readlines(chomp: true).map do |line|
  line.scan(/Step (\w) must be finished before step (\w) can begin./) do |step_1, step_2|
    steps << step_1 << step_2
    step_order[step_2] << step_1
  end
end

steps = steps.sort
correct_order = []

loop do
  break if steps.empty?

  available = steps.find { |step| step_order[step].empty? }
  correct_order << available
  step_order.transform_values { |v| v.delete(available) }
  steps.delete(available)
end

puts correct_order.join
