polymer = File.read('input.txt').chomp
pattern = Regexp.union(('a'..'z').flat_map { |s| [[s, s.upcase], [s.upcase, s]] }.map(&:join))

loop { break unless polymer.gsub!(pattern, '') }

puts polymer.length
