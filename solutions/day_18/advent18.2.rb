#!/usr/bin/env ruby

# --- Part Two ---
#
# How many safe tiles are there in a total of 400000 rows?

require_relative './advent18.1'

def total_rows
  400_000
end

p safe_tiles build_rows.join if __FILE__ == $0
