#!/usr/bin/env ruby

# --- Day 20: Firewall Rules ---
#
# You'd like to set up a small hidden computer here so you can use it to get back into the network later. However, the corporate firewall only allows communication with certain external IP addresses.
#
# You've retrieved the list of blocked IPs from the firewall, but the list seems to be messy and poorly maintained, and it's not clear which IPs are allowed. Also, rather than being written in dot-decimal notation, they are written as plain 32-bit integers, which can have any value from 0 through 4294967295, inclusive.
#
# For example, suppose only the values 0 through 9 were valid, and that you retrieved the following blacklist:
#
# 5-8
# 0-2
# 4-7
#
# The blacklist specifies ranges of IPs (inclusive of both the start and end value) that are not allowed. Then, the only IPs that this firewall allows are 3 and 9, since those are the only numbers not in any range.
#
# Given the list of blocked IPs you retrieved from the firewall (your puzzle input), what is the lowest-valued IP that is not blocked?

def blocked
  @blocked ||= STDIN.read.split("\n").map{|e| e.split('-').map(&:to_i).sort}.sort{|x,y| x[0] <=> y[0]}
end

def merge(a,b)
  if a[0] <= b[0] && a[1] >= b[1]
    a
  elsif b[0] <= a[0] && b[1] >= a[1]
    b
  elsif b[0] <= a[1] && a[0] <= b[0] && b[1] >= a[1]
    [a[0], b[1]]
  else
    nil
  end
end

def merged
  ranges = blocked.dup
  i = 0
  while i < ranges.count - 1
    a, b = ranges[i], ranges[i+1]
    r = merge(a, b)
    if r
      ranges[i] = r
      ranges[i+1] = nil
      ranges.compact!
    else
      i += 1
    end
  end
  ranges
end

def smallest
  merged.sort{|x,y| x[0] <=> y[0]}.each_cons(2) do |a,b|
    return a[1]+1 if (b[0] - a[1]) > 1
  end
end

p smallest if __FILE__ == $0
