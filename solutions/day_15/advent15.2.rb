#!/usr/bin/env ruby

# --- Part Two ---
#
# After getting the first capsule (it contained a star! what great fortune!), the machine detects your success and begins to rearrange itself.
#
# When it's done, the discs are back in their original configuration as if it were time=0 again, but a new disc with 11 positions and starting at position 0 has appeared exactly one second below the previously-bottom disc.
#
# With this new disc, and counting again starting from time=0 with the configuration in your puzzle input, what is the first time you can press the button to get another capsule?

require_relative './advent15.1'

def additional_discs
  [{number: 7, positions: 11, current_position: 0}]
end

def discs
  @discs ||= STDIN.read.split("\n").map{|d| parse_disc(d)} + additional_discs
  @discs.dup.map(&:dup)
end

p solve if __FILE__ == $0
