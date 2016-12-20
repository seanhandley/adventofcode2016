#!/usr/bin/env ruby

# --- Day 19: An Elephant Named Joseph ---

# The Elves contact you over a highly secure emergency channel. Back at the North Pole, the Elves are busy misunderstanding White Elephant parties.
#
# Each Elf brings a present. They all sit in a circle, numbered starting with position 1. Then, starting with the first Elf, they take turns stealing all the presents from the Elf to their left. An Elf with no presents is removed from the circle and does not take turns.
#
# For example, with five Elves (numbered 1 to 5):
#
#   1
# 5   2
#  4 3
#
# Elf 1 takes Elf 2's present.
# Elf 2 has no presents and is skipped.
# Elf 3 takes Elf 4's present.
# Elf 4 has no presents and is also skipped.
# Elf 5 takes Elf 1's two presents.
# Neither Elf 1 nor Elf 2 have any presents, so both are skipped.
# Elf 3 takes Elf 5's three presents.
#
# So, with five Elves, the Elf that sits starting in position 3 gets all the presents.
#
# With the number of Elves given in your puzzle input, which Elf gets all the presents?

def number_of_elves
  @number_of_elves ||= STDIN.read.to_i
end

def elves
  @elves ||= Array.new(number_of_elves) {|i| 1 }
end

def play
  i = 0
  while elves.select{|e| e > 0 }.count > 1 do
    next_index = (i == elves.count-1) ? 0 : i+1
    if elves[i] > 0
      steal_index = next_index
      until(elves[steal_index] != 0) do
        steal_index = (steal_index == elves.count-1) ? 0 : steal_index+1
      end
      elves[i] += elves[steal_index]
      elves[steal_index] = 0
    end
    i = next_index
    p elves.select{|e| e > 0 }.count
  end
  elves.index{|e| e > 0 }
end

p play+1 if __FILE__ == $0
