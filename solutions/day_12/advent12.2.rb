#!/usr/bin/env ruby

# --- Part Two ---
#
# As you head down the fire escape to the monorail, you notice it didn't start; register c needs to be initialized to the position of the ignition key.
#
# If you instead initialize register c to be 1, what value is now left in register a?

require_relative './advent12.1'

@register = {'a' => 0, 'b' => 0, 'c' => 1, 'd' => 0}

solve
p @register['a']
