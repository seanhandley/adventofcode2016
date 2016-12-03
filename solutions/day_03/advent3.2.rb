#!/usr/bin/env ruby

# --- Part Two ---
#
# Now that you've helpfully marked up their design documents, it occurs to you that triangles are specified in groups of three vertically. Each set of three numbers in a column specifies a triangle. Rows are unrelated.
#
# For example, given the following specification, numbers with the same hundreds digit would be part of the same triangle:
#
# 101 301 501
# 102 302 502
# 103 303 503
# 201 401 601
# 202 402 602
# 203 403 603
#
# In your puzzle input, and instead reading by columns, how many of the listed triangles are possible?

require_relative "./advent3.1"

def triangles
  a, b, c = [], [], []
  lines = STDIN.read.split("\n")
  lines.map do |line|
    a << line.scan(/\d+/)[0]
    b << line.scan(/\d+/)[1]
    c << line.scan(/\d+/)[2]
  end
  inputs = (a + b + c).flatten
  inputs.each_slice(3).to_a.map{|t| t.map(&:to_i).sort!}
end

p valid_triangle_count triangles
