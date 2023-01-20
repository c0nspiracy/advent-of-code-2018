# frozen_string_literal: true
input = ARGF.read.chomp.split.map(&:to_i)

def parse_node(input)
  metadata = []
  children_values = [0]

  child_nodes, metadata_entries = input.shift(2)

  child_nodes.times do
    input, md, value = parse_node(input)
    children_values << value
    metadata += md
  end

  this_node_metadata = input.shift(metadata_entries)

  if child_nodes.zero?
    value = this_node_metadata.sum
  else
    value = children_values.values_at(*this_node_metadata).compact.sum
  end

  metadata += this_node_metadata

  [input, metadata, value]
end

_, metadata, value = parse_node(input)

puts "Part 1: #{metadata.sum}"
puts "Part 2: #{value}"
