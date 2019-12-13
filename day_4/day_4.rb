require 'time'

timestamps = File.readlines('input.txt', chomp: true)

asleep = Hash.new { |h, k| h[k] = Hash.new(0) }
current_guard = 0
last_minute = 0

timestamps.sort.each do |line|
  match = line.match(/:(\d\d)\] (Guard #(\d+) begins shift|falls asleep|wakes up)$/)
  minute, action, guard_id = match.captures

  current_minute = minute.to_i
  current_guard = guard_id.to_i if guard_id

  if action == 'wakes up'
    last_minute.upto(current_minute - 1) { |min| asleep[current_guard][min] += 1 }
  end

  last_minute = current_minute
end

chosen_guard, sleep_minutes = asleep.max_by { |_guard, minutes| minutes.values.sum }
minute_asleep_most = sleep_minutes.max_by(&:last).first

puts chosen_guard * minute_asleep_most

chosen_guard_2, sleep_minutes = asleep.max_by { |_guard, minutes| minutes.values.max }
minute_asleep_most = sleep_minutes.max_by(&:last).first

puts chosen_guard_2 * minute_asleep_most
