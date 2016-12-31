#!/usr/bin/env ruby

# --- Part Two ---
#
# The safe doesn't open, but it does make several angry noises to express its frustration.
#
# You're quite sure your logic is working correctly, so the only other thing is... you check the painting again. As it turns out, colored eggs are still eggs. Now you count 12.
#
# As you run the program with this new input, the prototype computer begins to overheat. You wonder what's taking so long, and whether the lack of any instruction more powerful than "add one" has anything to do with it. Don't bunnies usually multiply?
#
# Anyway, what value should actually be sent to the safe?

require_relative './advent23.1'

@register['a'] = 12

def optimize_instructions
  # discover jnz hotspots
  # calculate number of incs/decs required
  # replace inc/jnz with mpl call
end

if __FILE__ == $0
  optimize_instructions
  solve
  p @register['a']
end