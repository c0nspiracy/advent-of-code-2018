box_ids = File.readlines('input.txt', chomp: true)

def comb(pair)
  pair.map(&:chars).reduce(:zip)
end

correct_id_pair = box_ids.combination(2).detect do |pair_of_ids|
  comb(pair_of_ids).one? { |l1, l2| l1 != l2 }
end

common_letters = comb(correct_id_pair).each_with_object("") do |(l1, l2), memo|
  memo << l1 if l1 == l2
end

puts common_letters
