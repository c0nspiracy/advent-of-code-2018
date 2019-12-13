input_polymer = File.read('input.txt').chomp
pattern = Regexp.union(('a'..'z').flat_map { |s| [[s, s.upcase], [s.upcase, s]] }.map(&:join))

answer = input_polymer.downcase.chars.uniq.map do |c|
  polymer = input_polymer.dup.delete([c, c.upcase].join)

  loop { break unless polymer.gsub!(pattern, '') }

  polymer.length
end.min

puts answer
