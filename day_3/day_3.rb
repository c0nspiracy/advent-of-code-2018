class Claim
  def self.parse(data)
    match = data.match(/^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/)
    raise ArgumentError, "Invalid data" unless match

    new(*match.captures.map(&:to_i))
  end

  attr_reader :id, :x, :y, :width, :height

  def initialize(id, x, y, width, height)
    @id = id
    @x = x
    @y = y
    @width = width
    @height = height
  end
end

claims = File.readlines('input.txt', chomp: true).map { |line| Claim.parse(line) }

fabric = Hash.new { |h, k| h[k] = [] }

claims.each do |claim|
  claim.width.times do |dx|
    claim.height.times do |dy|
      fabric[[claim.y + dy, claim.x + dx]] << claim.id
    end
  end
end

overlapping_claims = fabric.values.select { |v| v.size >= 2 }
all_claim_ids = claims.map(&:id)
non_overlapping_claim_ids = all_claim_ids - overlapping_claims.flatten.uniq

puts "Part 1 answer: #{overlapping_claims.size}"
puts "Part 2 answer: #{non_overlapping_claim_ids.first}"
