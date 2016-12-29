#!/usr/bin/env ruby

# --- Part Two ---
#
# The second disk you have to fill has length 35651584. Again using the initial state in your puzzle input, what is the correct checksum for this disk?

require_relative "./advent16.1"

def disk_size
  35651584
end

puts checksum data if __FILE__ == $0