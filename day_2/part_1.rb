box_ids = File.readlines('input.txt', chomp: true)

letter_frequencies = box_ids.flat_map do |box_id|
  box_id.chars.uniq.map do |letter|
    box_id.count(letter)
  end.uniq
end

puts letter_frequencies.count(2) * letter_frequencies.count(3)
