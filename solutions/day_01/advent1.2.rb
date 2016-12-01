#!/usr/bin/env ruby

# --- Part Two ---
#
# Then, you notice the instructions continue on the back of the Recruiting Document. Easter Bunny HQ is actually at the first location you visit twice.
#
# For example, if your instructions are R8, R4, R4, R8, the first location you visit twice is 4 blocks away, due East.
#
# How many blocks away is the first location you visit twice?

instructions = STDIN.read.split(", ").map{|e| [e[0], e[1..-1].to_i]}
directions   = [:north, :east, :south, :west].cycle(100).to_a
x, y, s      = 0, 0, 0
@visited     = [[0,0]]

def visited?(x, y)
  @visited.include?([x,y]) ? (p x.abs + y.abs) : (@visited << [x,y]; nil)
end

instructions.each do |turn, distance|
  turn == 'R' ? s += 1 : s -= 1
  case directions[s]
  when :north
    distance.times { y -= 1; exit if visited?(x,y)}
  when :east
    distance.times { x += 1; exit if visited?(x,y)}
  when :south
    distance.times { y += 1; exit if visited?(x,y)}
  when :west
    distance.times { x -= 1; exit if visited?(x,y)}
  end
end
