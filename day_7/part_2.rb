# frozen_string_literal: true

require "set"

step_order = Hash.new { |h, k| h[k] = [] }
steps = Set.new
num_workers = 5
step_time = 60

instructions = ARGF.readlines(chomp: true).map do |line|
  line.scan(/Step (\w) must be finished before step (\w) can begin./) do |step_1, step_2|
    steps << step_1 << step_2
    step_order[step_2] << step_1
  end
end

steps = steps.sort
correct_order = []

workers = num_workers.times.map { |n| [n, nil] }.to_h
second = 0

loop do
  break if steps.empty? && workers.all? { |_id, job| job.nil? }

  workers_free = workers.count { |_id, job| job.nil? }
  available = steps.select { |step| step_order[step].empty? }

  available.first(workers_free).each do |step|
    worker_id, _ = workers.find { |_id, job| job.nil? }
    workers[worker_id] = [step, step_time + (step.ord - 64)]
    steps.delete(step)
  end

  workers.transform_values! do |step, seconds_remaining|
    next if step.nil?

    [step, seconds_remaining - 1]
  end

  workers.select { |_id, (_step, seconds)| seconds == 0 }.each do |id, (step, _)|
    correct_order << step
    step_order.transform_values { |v| v.delete(step) }
    workers[id] = nil
  end

  second += 1
end

puts second
